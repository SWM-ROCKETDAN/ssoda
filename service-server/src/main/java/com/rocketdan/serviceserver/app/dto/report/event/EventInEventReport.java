package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.event.Event;

import java.util.Optional;

public class EventInEventReport {
    private String imagePath;
    private String title;
    private Integer status;

    public EventInEventReport(Event entity) {
        Optional.ofNullable(entity.getImagePaths()).ifPresent(none -> this.imagePath = entity.getImagePaths().get(0));
        this.title = entity.getTitle();
        this.status = entity.getStatus();
    }
}
