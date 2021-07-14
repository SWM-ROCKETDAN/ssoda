package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import lombok.Getter;

@Getter
public class HashtagEventUpdateRequest extends EventUpdateRequestDto {
    private Hashtag detail;
/*
    @Builder
    public HashtagEventUpdateRequest(String title, int status, List<String> images, Period period, List<Reward> rewards, int type, Hashtag detail) {
        super(title, status, images, period, rewards);
        this.detail = detail;
    }*/
}
