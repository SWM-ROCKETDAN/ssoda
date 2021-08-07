package com.rocketdan.serviceserver.web;

import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.service.JoinPostService;
import com.rocketdan.serviceserver.service.JoinUserService;
import com.rocketdan.serviceserver.service.RewardService;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelRequestDto;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/join")
public class JoinApiController {
    private final JoinPostService joinPostService;
    private final JoinUserService joinUserService;
    private final RewardService rewardService;

    @PostMapping("/events/{event_id}")
    public RewardResponseDto joinEventAndRetrieveReward(@PathVariable Long event_id, @RequestBody RewardLevelRequestDto requestDto) {
        // (1) join_post 저장
        Long joinPostId = joinPostService.save(event_id, requestDto.getUrl());

        // (2) analysis-server에 join_post update 요청
        CommonResponse putJoinPostResponse = joinPostService.putJoinPost(joinPostId);
        if (!putJoinPostResponse.getCode().equals("SUCCESS001")) {
            throw new JoinEventFailedException();
        }

        // (3) join_post의 snsId, type, createDate를 join_user에 저장
        Long joinUserId = joinUserService.save(joinPostId);

        // (4) analysis-server에 join_user update 요청
        CommonResponse putJoinUserResponse = joinUserService.putJoinUser(joinUserId);
        if (!putJoinUserResponse.getCode().equals("SUCCESS002")) {
            throw new JoinEventFailedException();
        }

        // (5) analysis-server에 reward level 요청
        RewardLevelResponseDto rewardLevelResponseDto = rewardService.getRewardId(joinPostId);

        // (6) reward 찾아 front에 return
        return rewardService.findById(rewardLevelResponseDto.getReward_id());
    }
}
