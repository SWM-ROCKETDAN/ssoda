package com.rocketdan.serviceserver.service;


import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import com.rocketdan.serviceserver.domain.event.reward.RewardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class RewardService {
    private final RewardRepository rewardRepository;
    private final EventRepository eventRepository;

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

    private WebClient webClient = WebClient.builder()
            .baseUrl("http://54.180.141.90:8080/api/v1/join/rewards")
            .build();

    // analysis-server에 put 요청
    public RewardLevelResponseDto getRewardLevel(Long joinPostId) {
        return webClient.get() // PUT method
                .uri("/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(AnalysisServerErrorException::new))
                .bodyToMono(RewardLevelResponseDto.class) // body type
                .block(); // await
    }
    
}
