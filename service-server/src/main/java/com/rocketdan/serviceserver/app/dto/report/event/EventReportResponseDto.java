package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.event.EventReport;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportResponseDto {
    private EventInEventReport event;
    private EventReport report;

    public EventReportResponseDto(EventInEventReport event, EventReportDto report) {
        this.event = event;
        this.report = report.getEvent_report();
    }
}
