package com.rocketdan.serviceserver.web;

import com.rocketdan.serviceserver.Exception.JoinEventFailedException;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.service.JoinPostService;
import com.rocketdan.serviceserver.service.JoinUserService;
import com.rocketdan.serviceserver.web.dto.RewardRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/join")
public class JoinApiController {
    private final JoinPostService joinPostService;
    private final JoinUserService joinUserService;

    @Transactional
    @GetMapping("/events/{event_id}")
    public void retrieveRewardLevel(@PathVariable Long event_id, @RequestBody RewardRequestDto rewardRequestDto) {
        // join_post 저장
        Long joinPostId = joinPostService.save(event_id, rewardRequestDto.getUrl());

        // analysis-server에 join_post update 요청
        CommonResponse putJoinPostResponse = joinPostService.putJoinPost(joinPostId);
        if (!putJoinPostResponse.getCode().equals("JOIN_POST200")) {
            throw new JoinEventFailedException();
        }

        // join_post의 snsId, type, createDate를 join_user에 저장
        Long joinUserId = joinUserService.save(joinPostId);

        // analysis-server에 join_user update 요청
        CommonResponse putJoinUserResponse = joinUserService.putJoinUser(joinUserId);
        if (!putJoinUserResponse.getCode().equals("JOIN_USER200")) {
            throw new JoinEventFailedException();
        }

        // analysis-server에 reward level 요청

        //return new RewardResponseDto();
    }
}
