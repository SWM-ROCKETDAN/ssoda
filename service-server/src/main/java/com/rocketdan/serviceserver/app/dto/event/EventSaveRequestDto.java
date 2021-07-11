package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@Getter
public class EventSaveRequestDto {
    private String title;
    private int status;
    private List<String> images;
    private Period period;
    private List<Reward> rewards;
    private int type;

    public EventSaveRequestDto(String title, int status, List<String> images, Period period, List<Reward> rewards, int type) {
        this.title = title;
        this.status = status;
        this.images = images;
        this.period = new Period(period.getPermanent(), period.getStart(), period.getStart());
        this.rewards = new ArrayList<>();
        rewards.forEach(reward ->
                this.rewards.add(new Reward(reward.getCategory(), reward.getName(), reward.getImage(), reward.getPrice(), reward.getCount())));
        this.type = type;
    }
}
