package com.rocketdan.serviceserver.app.dto.rank;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class EventRanksReceiveDto {
    private List<EventRankReceiveDto> event_ranks;

    @Builder
    public EventRanksReceiveDto(List<EventRankReceiveDto> event_ranks) {
        this.event_ranks = event_ranks;
    }
}
