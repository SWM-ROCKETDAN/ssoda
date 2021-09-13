package com.rocketdan.serviceserver.app.dto.report.store;

import com.rocketdan.serviceserver.domain.report.Report;
import lombok.Getter;

@Getter
public class ReportOfStoreDto {
    private Report<Integer> store_report;
}
