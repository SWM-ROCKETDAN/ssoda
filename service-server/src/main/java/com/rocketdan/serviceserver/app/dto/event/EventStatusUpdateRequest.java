package com.rocketdan.serviceserver.app.dto.event;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventStatusUpdateRequest {
    private Integer status;

    @Builder
    public EventStatusUpdateRequest(Integer status) {
        this.status = status;
    }
}
