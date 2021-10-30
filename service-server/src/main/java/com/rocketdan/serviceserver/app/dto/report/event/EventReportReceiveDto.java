package com.rocketdan.serviceserver.app.dto.report.event;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportReceiveDto {
    private EventReportInEventReportResponseDto event_report;

    @Builder
    public EventReportReceiveDto(EventReportInEventReportResponseDto event_report) {
        this.event_report = event_report;
    }
}
