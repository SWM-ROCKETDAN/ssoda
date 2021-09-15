package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.report.ReportOfEventDto;
import com.rocketdan.serviceserver.app.dto.report.ReportOfStoreDto;
import com.rocketdan.serviceserver.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/report")
public class ReportApiController {
    private final ReportService reportService;

    @GetMapping("/events/{event_id}")
    public ReportOfEventDto retrieveReportOfEvent(@PathVariable Long event_id) {
        return reportService.getReportOfEvent(event_id);
    }

    @GetMapping("/stores/{store_id}")
    public ReportOfStoreDto retrieveReportOfStore(@PathVariable Long store_id) {
        return reportService.getReportOfStore(store_id);
    }

}
