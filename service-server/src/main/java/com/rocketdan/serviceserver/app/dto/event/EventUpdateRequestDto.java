package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.detail.DetailByType;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventUpdateRequestDto {
    private String title;
    private int status;
    private List<String> images;
    private Period period;
    private List<Reward> rewards;

    public EventUpdateRequestDto(String title, int status, List<String> images, Period period, List<Reward> rewards) {
        this.title = title;
        this.status = status;
        this.images = images;
        this.period = new Period(period.getIsPermanent(), period.getStartDate(), period.getFinishDate());
        this.rewards = new ArrayList<>();
        rewards.forEach(reward ->
                this.rewards.add(new Reward(reward.getCategory(), reward.getName(), reward.getImage(), reward.getPrice(), reward.getCount())));
    }
}
