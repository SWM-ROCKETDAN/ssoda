package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.rank.GetRankFailedException;
import com.rocketdan.serviceserver.app.dto.rank.EventRankReceiveDto;
import com.rocketdan.serviceserver.app.dto.rank.EventRankResponseDto;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RankService {
    private final EventRepository eventRepository;
    private final AnalysisServerConfig analysisServerConfig;

    @Transactional(readOnly = true)
    public EventRankResponseDto wrapEventRank(EventRankReceiveDto eventRankReceiveDto) {
        Event event = eventRepository.findById(eventRankReceiveDto.getEvent_id()).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + eventRankReceiveDto.getEvent_id()));
        Store store = event.getStore();
        return new EventRankResponseDto(event, store, eventRankReceiveDto);
    }

    // analysis-server에 event rank get 요청
    public CommonResponse getEventRank(String sort) {
        return analysisServerConfig.webClient().get() // GET method
                .uri("/api/v1/rank/" + sort + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(GetRankFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }
}
