package com.rocketdan.serviceserver.app.dto.report;

import com.rocketdan.serviceserver.domain.report.ReportByPeriod;

import java.util.List;

public class ReportOfEventDto {
    private ReportByPeriod<List<Integer>> event_report;
}
