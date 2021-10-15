package com.rocketdan.serviceserver.app;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.app.dto.rank.EventRankDto;
import com.rocketdan.serviceserver.app.dto.rank.EventRankResponseDto;
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
    public List<EventRankResponseDto> retrieveEventRank(@RequestParam String sort) {
        ObjectMapper objectMapper = new ObjectMapper();
        List<EventRankDto> eventRankDtoList = objectMapper.convertValue(rankService.getEventRank(sort).getData(), new TypeReference<List<EventRankDto>>(){});

        List<EventRankResponseDto> eventRankResponseDtoList = new ArrayList<>();
        for (EventRankDto eventRankDto : eventRankDtoList) {
            eventRankResponseDtoList.add(rankService.wrapEventRank(eventRankDto));
        }
        return eventRankResponseDtoList;
    }
}
