package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
public class EventSaveRequestDto {
    private String title;
    private Date startDate;
    private Date finishDate;
    private List<Reward> rewards;

    public EventSaveRequestDto(String title, Date startDate, Date finishDate, List<Reward> rewards) {
        this.title = title;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.rewards = rewards;
    }
}
