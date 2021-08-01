package com.rocketdan.serviceserver.web.dto;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;

@Getter
public class RewardResponseDto {
    private Long level;
    private Integer category;
    private String name;
    private String image;

    public RewardResponseDto (Reward entity) {
        this.level = entity.getLevel();
        this.category = entity.getCategory();
        this.name = entity.getName();
        this.image = entity.getImage();
    }
}
