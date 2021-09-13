package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.event.Event;

public class EventInReportOfEvent {
    private String imagePath;
    private String title;
    private Integer status;

    public EventInReportOfEvent(Event entity) {
        this.imagePath = entity.getImagePaths().get(0);
        this.title = entity.getTitle();
        this.status = entity.getStatus();
    }
}
