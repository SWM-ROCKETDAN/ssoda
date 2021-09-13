package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.NoRewardForEventException;
import com.rocketdan.serviceserver.Exception.report.GetReportFailedException;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.report.event.EventInReportOfEvent;
import com.rocketdan.serviceserver.app.dto.report.event.ReportOfEventDto;
import com.rocketdan.serviceserver.app.dto.report.event.ReportOfEventResponseDto;
import com.rocketdan.serviceserver.app.dto.report.event.RewardInReportOfEvent;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.config.auth.UserIdValidCheck;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.reward.Reward;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReportService {
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

    private final UserIdValidCheck userIdValidCheck;

    // Report of event 가공
    public ReportOfEventResponseDto wrapReportOfEvent(Long eventId, ReportOfEventDto report, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Event event = eventRepository.findById(eventId).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + eventId));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(event.getStore().getUser().getUserId(), principal);

        // Reward >= 1 인지 체크
        List<Reward> rewards = event.getRewards();
        if (rewards.size() == 0) {
            throw new NoRewardForEventException();
        }

        return new ReportOfEventResponseDto(new EventInReportOfEvent(event), processRewards(rewards), report);
    }

    // rewards 가공
    private List<RewardInReportOfEvent> processRewards(List<Reward> rewards) {
        List<RewardInReportOfEvent> rewardsInReportOfEvent = new ArrayList<>();
        rewards.forEach(reward -> rewardsInReportOfEvent.add(new RewardInReportOfEvent(reward)));
        return rewardsInReportOfEvent;
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
