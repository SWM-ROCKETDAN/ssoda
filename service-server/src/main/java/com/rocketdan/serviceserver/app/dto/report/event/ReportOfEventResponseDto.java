package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.report.ReportByPeriod;

import java.util.List;

public class ReportOfEventResponseDto {
    private EventInReportOfEvent event;
    private List<RewardInReportOfEvent> rewards;
    private ReportByPeriod<List<Integer>> report;

    public ReportOfEventResponseDto(EventInReportOfEvent event, List<RewardInReportOfEvent> rewards, ReportOfEventDto report) {
        this.event = event;
        this.rewards = List.copyOf(rewards);
        this.report = report.getEvent_report();
    }
}
