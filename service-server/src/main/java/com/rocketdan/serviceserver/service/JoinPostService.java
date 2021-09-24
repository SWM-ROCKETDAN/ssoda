package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinDifferentEventException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.Exception.join.JoinInvalidEventException;
import com.rocketdan.serviceserver.Exception.join.NoRewardForEventException;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import com.rocketdan.serviceserver.domain.reward.Reward;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Objects;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinPostService {
    private final JoinPostRepository joinPostRepository;
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

    @Transactional
    public Long save(Long event_id, String url) {
        // (1) URL 중복 검사
        Optional<JoinPost> joinPost = joinPostRepository.findByUrl(url);
        if (joinPost.isPresent()) {
            // 해당 게시글로 참여했던 event와 현재 요청한 event가 같은지 검사
            if (!Objects.equals(event_id, joinPost.get().getEvent().getId())){
                throw new JoinDifferentEventException();
            }
            return joinPost.get().getId();
        }

        // (2) Event validate 검사
        Event linkedEvent = eventRepository.findById(event_id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + event_id));

        if (linkedEvent.getStatus() != 1) { // 진행중인 이벤트가 아닐 경우
            throw new JoinInvalidEventException();
        }

        if (linkedEvent.getRewards().size() == 0) {
            throw new NoRewardForEventException();
        }

        // (3) Analysis server에 요청
        JoinPost savedJoinPost = JoinPost.builder()
                .event(linkedEvent)
                .url(url)
                .createDate(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime())
                .build();

        return joinPostRepository.save(savedJoinPost).getId();
    }

    @Transactional
    public Integer updateReward(Long postId) {
        JoinPost joinPost = joinPostRepository.findById(postId).orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. id=" + postId));

        // (1) Reward 수령 여부 확인
        if (joinPost.getRewardDate() != null) {
            throw new JoinEventFailedException("Post is already rewarded");
        }

        Reward reward = joinPost.getReward();

        // (2) usedCount 감소
        Integer increasedUsedCount = reward.increaseUsedCount();

        // (3) rewardDate update
        LocalDateTime now = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime();
        joinPost.updateRewardDate(now);

        // (4) usedCount >= count -> 이벤트 종료
        if (increasedUsedCount >= reward.getCount()) {
            joinPost.getEvent().updateStatus(2); // 종료
        }

        return reward.getCount() - increasedUsedCount;
    }

    @Retryable(maxAttempts = 2, value = AnalysisServerErrorException.class)
    public CommonResponse putJoinPost(Long joinPostId) {
        return analysisServerConfig.webClient().put() // PUT method
                .uri("/api/v1/join/posts/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }

}
