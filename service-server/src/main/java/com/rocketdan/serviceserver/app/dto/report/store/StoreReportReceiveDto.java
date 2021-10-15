package com.rocketdan.serviceserver.app.dto.report.store;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StoreReportReceiveDto {
    private StoreReportInStoreReportResponseDto store_report;

    @Builder
    public StoreReportReceiveDto(StoreReportInStoreReportResponseDto store_report) {
        this.store_report = store_report;
    }
}
