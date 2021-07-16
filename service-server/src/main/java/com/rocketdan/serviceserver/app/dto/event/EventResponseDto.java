package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventResponseDto {
    private Long id;
    private String title;
    private Integer status;
    private Date startDate;
    private Date finishDate;
    private List<String> images;
    private List<Reward> rewards;
    private String type;

    public EventResponseDto(Event entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.status = entity.getStatus();
        this.startDate = entity.getStartDate();
        this.finishDate = entity.getFinishDate();
        this.images = entity.getImages();
        this.rewards = entity.getRewards();
        this.type = entity.getType();
    }
}
