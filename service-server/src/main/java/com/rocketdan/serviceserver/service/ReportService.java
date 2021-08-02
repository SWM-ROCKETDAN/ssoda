package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.JoinEventFailedException;
import com.rocketdan.serviceserver.app.dto.report.ReportOfEventDto;
import com.rocketdan.serviceserver.app.dto.report.ReportOfStoreDto;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
public class ReportService {
    private WebClient webClient = WebClient.builder()
            .baseUrl("http://analysisserverurl:8080/api/v1/report")
            .build();

    // analysis-server에 event report get 요청
    public ReportOfEventDto getReportOfEvent(Long eventId) {
        return webClient.get() // GET method
                .uri("/event/" + eventId) // baseUrl 이후 uri
                .retrieve() // client message 전송
//                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(GetReportFailedException::new))
                .bodyToMono(ReportOfEventDto.class) // body type
                .block(); // await
    }

    // analysis-server에 store report get 요청
    public ReportOfStoreDto getReportOfStore(Long storeId) {
        return webClient.get() // GET method
                .uri("/store/" + storeId) // baseUrl 이후 uri
                .retrieve() // client message 전송
//                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(GetReportFailedException::new))
                .bodyToMono(ReportOfStoreDto.class) // body type
                .block(); // await
    }
}
