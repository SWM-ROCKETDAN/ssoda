package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.event.EventReport;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportDto {
    private EventReport event_report;

    @Builder
    public EventReportDto(EventReport event_report) {
        this.event_report = event_report;
    }
}
