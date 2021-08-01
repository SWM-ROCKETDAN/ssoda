package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.domain.join.post.JoinPost;
import com.rocketdan.serviceserver.domain.join.post.JoinPostRepository;
import com.rocketdan.serviceserver.domain.join.user.JoinUser;
import com.rocketdan.serviceserver.domain.join.user.JoinUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class JoinUserService {
    private final JoinUserRepository joinUserRepository;
    private final JoinPostRepository joinPostRepository;

    @Transactional
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
}
