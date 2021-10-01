package com.rocketdan.serviceserver.web;

import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.service.JoinPostService;
import com.rocketdan.serviceserver.service.JoinUserService;
import com.rocketdan.serviceserver.service.RewardService;
import com.rocketdan.serviceserver.web.dto.join.JoinEventResponseDto;
import com.rocketdan.serviceserver.web.dto.join.SaveJoinPostResult;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelRequestDto;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/join")
public class JoinApiController {
    private final JoinPostService joinPostService;
    private final JoinUserService joinUserService;
    private final RewardService rewardService;

    @PostMapping("/events/{event_id}")
    public JoinEventResponseDto joinEventAndRetrieveReward(@PathVariable Long event_id, @RequestBody RewardLevelRequestDto requestDto) {
        // (1) join_post 저장
        SaveJoinPostResult saveJoinPostResult = joinPostService.save(event_id, requestDto.getUrl());

        // (2) analysis-server에 join_post update 요청
        CommonResponse putJoinPostResponse = joinPostService.putJoinPost(saveJoinPostResult.getJoinPostId());

        // (3) join_post의 snsId, type, createDate를 join_user에 저장
        Long joinUserId = joinUserService.save(saveJoinPostResult.getJoinPostId());

        // (4) analysis-server에 join_user update 요청
        CommonResponse putJoinUserResponse = joinUserService.putJoinUser(joinUserId);

        // (5) analysis-server에 reward level 요청
        RewardLevelResponseDto rewardLevelResponse = rewardService.getRewardId(saveJoinPostResult.getJoinPostId(), saveJoinPostResult.getRewardPolicy());

        // (6) reward 찾아 front에 response
        return new JoinEventResponseDto(saveJoinPostResult.getJoinPostId(), rewardService.findById(rewardLevelResponse.getReward_id()));
    }

    @PutMapping("/posts/{post_id}")
    public ResponseEntity<CommonResponse> completedParticipation(@PathVariable Long post_id) {
        Integer remainCount = joinPostService.updateReward(post_id);

        return ResponseEntity.ok()
                .body(CommonResponse.builder()
                        .message("Successfully participated in the event.")
                        .code("COMPLETED_PARTICIPATION")
                        .status(200)
                        .data(remainCount.toString())
                        .build()
                );
    }
}
