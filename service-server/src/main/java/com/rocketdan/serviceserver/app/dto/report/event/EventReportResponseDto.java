package com.rocketdan.serviceserver.app.dto.report.event;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportResponseDto {
    private EventInEventReportResponseDto event;
    private EventReportInEventReportResponseDto report;

    public EventReportResponseDto(EventInEventReportResponseDto event, EventReportReceiveDto report) {
        this.event = event;
        this.report = report.getEvent_report();
    }
}
