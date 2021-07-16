package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventUpdateRequestDto {
    private String title;
    private Integer status;
    private Date startDate;
    private Date finishDate;
    private List<String> images;
    private List<Reward> rewards;

    public EventUpdateRequestDto(String title, Integer status, Date startDate, Date finishDate, List<String> images, List<Reward> rewards) {
        this.title = title;
        this.status = status;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
        this.rewards = rewards;
    }
}
