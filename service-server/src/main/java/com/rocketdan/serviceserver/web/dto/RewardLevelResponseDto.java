package com.rocketdan.serviceserver.web.dto;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;

@Getter
public class RewardLevelResponseDto {
    private Long level;

    public RewardLevelResponseDto(Reward entity) {
        this.level = entity.getLevel();
    }
}
