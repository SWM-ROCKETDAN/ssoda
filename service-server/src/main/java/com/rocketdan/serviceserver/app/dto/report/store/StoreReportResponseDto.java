package com.rocketdan.serviceserver.app.dto.report.store;

import com.rocketdan.serviceserver.domain.report.StoreReport;

public class StoreReportResponseDto {
    private StoreReport report;

    public StoreReportResponseDto(StoreReportDto report) {
        this.report = report.getStore_report();
    }
}
