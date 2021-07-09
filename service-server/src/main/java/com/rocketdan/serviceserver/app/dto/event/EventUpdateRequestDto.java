package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.detail.DetailByType;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class EventUpdateRequestDto {
    private String title;
    private int status;
    private List<String> images;
    private Period period;
    private List<Reward> rewards;
    private DetailByType detail;
}
