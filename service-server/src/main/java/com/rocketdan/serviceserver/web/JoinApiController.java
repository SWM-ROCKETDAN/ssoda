package com.rocketdan.serviceserver.web;

import com.rocketdan.serviceserver.service.JoinPostService;
import com.rocketdan.serviceserver.service.JoinUserService;
import com.rocketdan.serviceserver.service.RewardService;
import com.rocketdan.serviceserver.web.dto.RewardRequestDto;
import com.rocketdan.serviceserver.web.dto.RewardResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/join")
public class JoinApiController {
    private final JoinPostService joinPostService;
    private final JoinUserService joinUserService;
    private final RewardService rewardService;

    @GetMapping("/events/{event_id}")
    public RewardResponseDto retrieveRewardLevel(@PathVariable Long event_id, @RequestBody RewardRequestDto rewardRequestDto) {
        // join_post 저장
        Long joinPostId = joinPostService.save(event_id, rewardRequestDto.getUrl());

        // analysis-server에 join_post update 요청

        // join_post의 snsId, type, createDate를 join_user에 저장
        Long joinUserId = joinUserService.save(joinPostId);

        // analysis-server에 join_user update 요청

        // analysis-server에 reward level 요청

        return new RewardResponseDto();
    }
}
