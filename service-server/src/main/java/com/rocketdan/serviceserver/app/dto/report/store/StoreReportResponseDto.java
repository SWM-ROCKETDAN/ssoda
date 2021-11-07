package com.rocketdan.serviceserver.app.dto.report.store;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StoreReportResponseDto {
    private StoreReportInStoreReportResponseDto report;

    @Builder
    public StoreReportResponseDto(StoreReportReceiveDto report) {
        this.report = report.getStore_report();
    }
}
