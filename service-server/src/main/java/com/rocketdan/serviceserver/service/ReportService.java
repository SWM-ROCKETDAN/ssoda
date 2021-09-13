package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.report.GetReportFailedException;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.report.event.EventInEventReport;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportDto;
import com.rocketdan.serviceserver.app.dto.report.event.EventReportResponseDto;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.config.auth.UserIdValidCheck;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ReportService {
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

    private final UserIdValidCheck userIdValidCheck;

    // Report of event 가공
    public EventReportResponseDto wrapReportOfEvent(Long eventId, EventReportDto report, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Event event = eventRepository.findById(eventId).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + eventId));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(event.getStore().getUser().getUserId(), principal);

        return new EventReportResponseDto(new EventInEventReport(event), report);
    }

    // analysis-server에 event report get 요청
    public CommonResponse getReportOfEvent(Long eventId) {
        return analysisServerConfig.webClient().get() // GET method
                .uri("/api/v1/report/events/" + eventId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(GetReportFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }

    // analysis-server에 store report get 요청
    public CommonResponse getReportOfStore(Long storeId) {
        return analysisServerConfig.webClient().get() // GET method
                .uri("/api/v1/report/stores/" + storeId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(GetReportFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }
}
