package com.rocketdan.serviceserver.domain.report;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventReportByPeriod {
    private EventReport day;
    private EventReport week;
    private EventReport month;
}
