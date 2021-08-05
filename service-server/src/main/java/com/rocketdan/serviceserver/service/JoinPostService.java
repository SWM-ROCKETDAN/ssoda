package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.DuplicateUrlException;
import com.rocketdan.serviceserver.Exception.JoinEventFailedException;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import lombok.RequiredArgsConstructor;

import org.hibernate.mapping.Join;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Date;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinPostService {
    private final JoinPostRepository joinPostRepository;
    private final EventRepository eventRepository;

    private WebClient webClient = WebClient.builder()
            .baseUrl("http://54.180.141.90:8080/api/v1/join/post")
            .build();

    @Transactional
    public Long save(Long event_id, String url) {
        // 중복된 url일 경우 exception 발생
        if (duplicateCheck(url)) {
            throw new DuplicateUrlException();
        }

        Event linkedEvent = eventRepository.findById(event_id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + event_id));
        JoinPost savedJoinPost = JoinPost.builder()
                .event(linkedEvent)
                .url(url)
                .createDate(new Date())
                .build();

        return joinPostRepository.save(savedJoinPost).getId();
    }

    private Boolean duplicateCheck(String url) {
        Optional<JoinPost> joinPost = joinPostRepository.findByUrl(url);
        return joinPost.isPresent(); // 중복 : true, 중복 x : false
    }

    public CommonResponse putJoinPost(Long joinPostId) {
        return webClient.put() // PUT method
                .uri("/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }

}
