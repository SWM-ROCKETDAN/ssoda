package com.rocketdan.serviceserver.app.dto.report.store;

import com.rocketdan.serviceserver.domain.report.StoreReport;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StoreReportDto {
    private StoreReport store_report;

    @Builder
    public StoreReportDto(StoreReport store_report) {
        this.store_report = store_report;
    }
}
