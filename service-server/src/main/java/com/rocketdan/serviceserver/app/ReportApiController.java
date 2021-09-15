package com.rocketdan.serviceserver.app;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportDto;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportResponseDto;
import com.rocketdan.serviceserver.app.dto.report.store.StoreReportDto;
import com.rocketdan.serviceserver.app.dto.report.store.StoreReportResponseDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/report")
public class ReportApiController {
    private final ReportService reportService;

    @GetMapping("/events/{event_id}")
    public EventReportResponseDto retrieveReportOfEvent(@PathVariable Long event_id, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        ObjectMapper objectMapper = new ObjectMapper();
        EventReportDto eventReportDto = objectMapper.convertValue(reportService.getReportOfEvent(event_id).getData(), EventReportDto.class);

        return reportService.wrapEventReport(event_id, eventReportDto, principal);
    }

    @GetMapping("/stores/{store_id}")
    public StoreReportResponseDto retrieveReportOfStore(@PathVariable Long store_id, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        ObjectMapper objectMapper = new ObjectMapper();
        StoreReportDto storeReportDto = objectMapper.convertValue(reportService.getReportOfStore(store_id).getData(), StoreReportDto.class);

        return reportService.wrapStoreReport(store_id, storeReportDto, principal);
    }
}
