package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.EventReportByPeriod;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportDto {
    private EventReportByPeriod event_report;

    @Builder
    public EventReportDto(EventReportByPeriod event_report) {
        this.event_report = event_report;
    }
}
