package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.JoinEventFailedException;
import com.rocketdan.serviceserver.Exception.LoginFailedException;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinPostService {
    private final JoinPostRepository joinPostRepository;
    private final EventRepository eventRepository;

    @Transactional
    public Long save(Long event_id, String url) {
        // 중복된 url일 경우 exception 발생
        if (duplicateCheck(url)) {
            throw new JoinEventFailedException();
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

}
