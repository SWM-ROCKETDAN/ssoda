package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import com.rocketdan.serviceserver.domain.join.user.JoinUser;
import com.rocketdan.serviceserver.domain.join.user.JoinUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Mono;

import java.util.Date;
import java.util.Objects;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinUserService {
    private final JoinUserRepository joinUserRepository;
    private final JoinPostRepository joinPostRepository;

    private final AnalysisServerConfig analysisServerConfig;

    public Long save(Long joinPostId) {
        JoinPost linkedJoinPost = joinPostRepository.findById(joinPostId).orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. id=" + joinPostId));

        // 같은 snsId, type을 가진 join user 가 존재할 경우 저장하지 않고 리턴
        Optional<JoinUser> joinUser = joinUserRepository.findBySnsIdAndType(linkedJoinPost.getSnsId(), linkedJoinPost.getType());
        if (joinUser.isPresent()) {
            return joinUser.get().getId();
        }

        JoinUser savedJoinUser = JoinUser.builder()
                .snsId(linkedJoinPost.getSnsId())
                .type(linkedJoinPost.getType())
                .createDate(new Date())
                .build();

        return joinUserRepository.save(savedJoinUser).getId();
    }

    // analysis-server에 put 요청
    @Retryable(maxAttempts = 2, value = AnalysisServerErrorException.class)
    public CommonResponse putJoinUser(Long joinUserId) {
       return analysisServerConfig.webClient().put() // PUT method
                .uri("/api/v1/join/users/" + joinUserId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(new JoinEventFailedException(Objects.requireNonNull(clientResponse.bodyToMono(CommonResponse.class).block()))))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(new AnalysisServerErrorException(Objects.requireNonNull(clientResponse.bodyToMono(CommonResponse.class).block()))))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }
}
