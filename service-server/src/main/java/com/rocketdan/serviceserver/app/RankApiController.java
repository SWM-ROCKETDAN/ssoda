package com.rocketdan.serviceserver.app;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.app.dto.rank.EventRankReceiveDto;
import com.rocketdan.serviceserver.app.dto.rank.EventRankResponseDto;
import com.rocketdan.serviceserver.app.dto.rank.EventRanksReceiveDto;
import com.rocketdan.serviceserver.service.RankService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/rank")
public class RankApiController {
    private final RankService rankService;

    @GetMapping()
    public List<EventRankResponseDto> retrieveEventRank(@RequestParam String sort, @RequestParam Integer limit) {
        ObjectMapper objectMapper = new ObjectMapper();
        List<EventRankReceiveDto> eventRankReceiveDtoList = objectMapper.convertValue(rankService.getEventRank(sort, limit).getData(), EventRanksReceiveDto.class).getEvent_ranks();

        List<EventRankResponseDto> eventRankResponseDtoList = new ArrayList<>();
        for (EventRankReceiveDto eventRankReceiveDto : eventRankReceiveDtoList) {
            eventRankResponseDtoList.add(rankService.wrapEventRank(eventRankReceiveDto));
        }
        return eventRankResponseDtoList;
    }
}
