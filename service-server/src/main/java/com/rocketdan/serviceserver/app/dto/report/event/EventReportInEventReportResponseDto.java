package com.rocketdan.serviceserver.app.dto.report.event;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportInEventReportResponseDto {
    private EventReportByPeriod day;
    private EventReportByPeriod week;
    private EventReportByPeriod month;
    private EventReportTotal total;
}
