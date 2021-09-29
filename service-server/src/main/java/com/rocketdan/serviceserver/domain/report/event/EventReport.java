package com.rocketdan.serviceserver.domain.report.event;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReport {
    private EventReportByPeriod day;
    private EventReportByPeriod week;
    private EventReportByPeriod month;
    private EventReportTotal total;
}
