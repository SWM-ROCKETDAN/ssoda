package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.report.ReportOfEventDto;
import com.rocketdan.serviceserver.app.dto.report.ReportOfStoreDto;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class ReportService {
    private WebClient webClient = WebClient.builder()
            .baseUrl("http://54.180.141.90:8080/api/v1/report")
            .build();

    // analysis-server에 event report get 요청
    public ReportOfEventDto getReportOfEvent(Long eventId) {
        return webClient.get() // GET method
                .uri("/events/" + eventId) // baseUrl 이후 uri
                .retrieve() // client message 전송
//                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(GetReportFailedException::new))
                .bodyToMono(ReportOfEventDto.class) // body type
                .block(); // await
    }

    // analysis-server에 store report get 요청
    public ReportOfStoreDto getReportOfStore(Long storeId) {
        return webClient.get() // GET method
                .uri("/stores/" + storeId) // baseUrl 이후 uri
                .retrieve() // client message 전송
//                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(GetReportFailedException::new))
                .bodyToMono(ReportOfStoreDto.class) // body type
                .block(); // await
    }
}
