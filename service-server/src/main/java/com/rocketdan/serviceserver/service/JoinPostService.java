package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.DuplicateUrlException;
import com.rocketdan.serviceserver.Exception.join.JoinDifferentEventException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.Exception.join.JoinInvalidEventException;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Mono;

import java.util.Date;
import java.util.Objects;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinPostService {
    private final JoinPostRepository joinPostRepository;
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

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

        // (3) Analysis server에 요청
        JoinPost savedJoinPost = JoinPost.builder()
                .event(linkedEvent)
                .url(url)
                .createDate(new Date())
                .build();

        return joinPostRepository.save(savedJoinPost).getId();
    }

    public CommonResponse putJoinPost(Long joinPostId) {
        return analysisServerConfig.webClient().put() // PUT method
                .uri("/api/v1/join/posts/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }

}
