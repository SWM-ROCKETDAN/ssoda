package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.Getter;

import java.util.List;

@Getter
public class EventResponseDto {
    private String id;
    private String title;
    private int status;
    private List<String> images;
    private Period period;
    private List<Reward> rewards;
    private int type;/*
    private DetailByType detail;

    public EventResponseDto(Event entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.images = entity.getImages();
        this.status = entity.getStatus();
        this.period = entity.getPeriod();
        this.rewards = entity.getRewards();
        this.type = entity.getType();
        this.detail = entity.getDetail();
    }*/
}
