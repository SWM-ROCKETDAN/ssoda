package com.rocketdan.serviceserver.app.dto.report.store;

import com.rocketdan.serviceserver.domain.report.Report;

public class ReportOfStoreResponseDto {
    private Report<Integer> report;

    public ReportOfStoreResponseDto(ReportOfStoreDto report) {
        this.report = report.getStore_report();
    }
}
