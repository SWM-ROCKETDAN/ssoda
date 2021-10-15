package com.rocketdan.serviceserver.app;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportReceiveDto;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportResponseDto;
import com.rocketdan.serviceserver.app.dto.report.store.StoreReportReceiveDto;
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
        EventReportReceiveDto eventReportReceiveDto = objectMapper.convertValue(reportService.getReportOfEvent(event_id).getData(), EventReportReceiveDto.class);

        return reportService.wrapEventReport(event_id, eventReportReceiveDto, principal);
    }

    @GetMapping("/stores/{store_id}")
    public StoreReportResponseDto retrieveReportOfStore(@PathVariable Long store_id, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        ObjectMapper objectMapper = new ObjectMapper();
        StoreReportReceiveDto storeReportReceiveDto = objectMapper.convertValue(reportService.getReportOfStore(store_id).getData(), StoreReportReceiveDto.class);

        return reportService.wrapStoreReport(store_id, storeReportReceiveDto, principal);
    }
}
