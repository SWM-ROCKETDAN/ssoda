package com.rocketdan.serviceserver.app.dto.reward;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class RewardResponseDto {
    private Long id;
    private Integer level;
    private Integer category;
    private String name;
    private String image;
    private Integer price;
    private Integer count;
    private Long event_id;

    public RewardResponseDto(Reward entity) {
        this.id = entity.getId();
        this.level = entity.getLevel();
        this.category = entity.getCategory();
        this.name = entity.getName();
        this.image = entity.getImage();
        this.price = entity.getPrice();
        this.count = entity.getCount();
        this.event_id = entity.getEvent().getId();
    }
}
