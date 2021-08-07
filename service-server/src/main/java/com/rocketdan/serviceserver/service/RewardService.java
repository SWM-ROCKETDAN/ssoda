package com.rocketdan.serviceserver.service;


import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.reward.Reward;
import com.rocketdan.serviceserver.domain.reward.RewardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class RewardService {
    private final RewardRepository rewardRepository;
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

    @Transactional
    public Long save(Long event_id, RewardSaveRequestDto requestDto, String imgPath) {
        Event linkedEvent = eventRepository.findById(event_id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + event_id));
        Reward savedReward = requestDto.toEntity(imgPath);
        savedReward.setEvent(linkedEvent);

        return rewardRepository.save(savedReward).getId();
    }

    @Transactional(readOnly = true)
    public RewardResponseDto findById(Long id) {
        Reward entity = rewardRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 리워드가 없습니다. id=" + id));
        return new RewardResponseDto(entity);
    }

    // analysis-server에 put 요청
    public RewardLevelResponseDto getRewardId(Long joinPostId) {
        return analysisServerConfig.webClient().get() // PUT method
                .uri("/api/v1/join/rewards/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(AnalysisServerErrorException::new))
                .bodyToMono(RewardLevelResponseDto.class) // body type
                .block(); // await
    }

    public void softDelete(Long id) {
        Reward reward = rewardRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 리워드가 없습니다. id=" + id));
        rewardRepository.delete(reward);
    }
}
