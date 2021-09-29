package com.rocketdan.serviceserver.app.dto.report.store;

import com.rocketdan.serviceserver.domain.report.store.StoreReport;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StoreReportResponseDto {
    private StoreReport report;

    @Builder
    public StoreReportResponseDto(StoreReportDto report) {
        this.report = report.getStore_report();
    }
}
