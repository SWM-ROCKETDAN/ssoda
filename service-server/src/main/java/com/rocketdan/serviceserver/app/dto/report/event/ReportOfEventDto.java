package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.ReportByPeriod;
import lombok.Getter;

import java.util.List;

@Getter
public class ReportOfEventDto {
    private ReportByPeriod<List<Integer>> event_report;
}
