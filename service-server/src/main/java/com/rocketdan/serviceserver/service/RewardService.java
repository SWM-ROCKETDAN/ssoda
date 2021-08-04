package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.JoinEventFailedException;
import com.rocketdan.serviceserver.web.dto.RewardLevelResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class RewardService {
    private WebClient webClient = WebClient.builder()
            .baseUrl("http://54.180.141.90:8080/api/v1/join/reward")
            .build();

    // analysis-server에 put 요청
    public RewardLevelResponseDto getRewardLevel(Long joinPostId) {
        return webClient.get() // PUT method
                .uri("/" + joinPostId) // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(JoinEventFailedException::new))
                .bodyToMono(RewardLevelResponseDto.class) // body type
                .block(); // await
    }
}
