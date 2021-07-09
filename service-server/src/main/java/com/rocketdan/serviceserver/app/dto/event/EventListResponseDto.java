package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.element.Period;
import lombok.Getter;
import org.bson.types.ObjectId;

import java.util.List;

@Getter
public class EventListResponseDto {
    private ObjectId id;
    private String title;
    private int status;
    private List<String> images;
    private Period period;

    public EventListResponseDto(Event entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.images = entity.getImages();
        this.period = entity.getPeriod();
        this.status = entity.getStatus();
    }
}
