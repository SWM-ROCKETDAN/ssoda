package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.detail.Hashtag;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.Builder;

import java.util.List;

public class HashtagEventSaveRequest extends EventSaveRequestDto {
    private Hashtag detail;

    @Builder
    public HashtagEventSaveRequest(String title, int status, List<String> images, Period period, List<Reward> rewards, int type, Hashtag detail) {
        super(title, status, images, period, rewards, type);
        this.detail = detail;
    }

    public Event toEntity() {
        return Event.builder()
                .title(super.getTitle())
                .images(super.getImages())
                .status(super.getStatus())
                .period(super.getPeriod())
                .rewards(super.getRewards())
                .type(super.getType())
                .detail(detail)
                .build();
    }
}
