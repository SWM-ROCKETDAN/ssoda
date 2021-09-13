package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.EventReportByPeriod;
import lombok.Getter;

@Getter
public class EventReportDto {
    private EventReportByPeriod event_report;
}
