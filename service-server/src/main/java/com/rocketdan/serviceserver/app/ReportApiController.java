package com.rocketdan.serviceserver.app;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.report.event.ReportOfEventDto;
import com.rocketdan.serviceserver.app.dto.report.event.ReportOfEventResponseDto;
import com.rocketdan.serviceserver.app.dto.report.store.ReportOfStoreDto;
import com.rocketdan.serviceserver.app.dto.report.store.ReportOfStoreResponseDto;
import com.rocketdan.serviceserver.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/report")
public class ReportApiController {
    private final ReportService reportService;

    @GetMapping("/events/{event_id}")
    public ReportOfEventResponseDto retrieveReportOfEvent(@PathVariable Long event_id, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        ObjectMapper objectMapper = new ObjectMapper();
        ReportOfEventDto reportOfEventDto = objectMapper.convertValue(reportService.getReportOfEvent(event_id).getData(), ReportOfEventDto.class);

        return reportService.wrapReportOfEvent(event_id, reportOfEventDto, principal);
    }

    @GetMapping("/stores/{store_id}")
    public ReportOfStoreResponseDto retrieveReportOfStore(@PathVariable Long store_id) {
        ObjectMapper objectMapper = new ObjectMapper();
        ReportOfStoreDto reportOfStoreDto = objectMapper.convertValue(reportService.getReportOfStore(store_id).getData(), ReportOfStoreDto.class);

        return new ReportOfStoreResponseDto(reportOfStoreDto);
    }
}
