package com.rocketdan.serviceserver.web.dto.join;

import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class JoinEventResponseDto {
    private Long postId;
    private RewardResponseDto reward;

    public JoinEventResponseDto(Long postId, RewardResponseDto reward) {
        this.postId = postId;
        this.reward = reward;
    }
}
