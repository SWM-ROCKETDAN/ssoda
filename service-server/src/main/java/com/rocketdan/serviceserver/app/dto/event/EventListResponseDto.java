package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.element.Period;
import lombok.Getter;

import java.util.List;

@Getter
public class EventListResponseDto {
    private String id;
    private String title;
    private int status;
    private List<String> images;
    private Period period;
    private int type;

    public EventListResponseDto(Event entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.status = entity.getStatus();
        this.images = entity.getImages();
        this.period = entity.getPeriod();
        this.type = entity.getType();
    }
}
