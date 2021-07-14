package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Builder;
import lombok.Getter;

import java.util.Date;
import java.util.List;

@Getter
public class HashtagEventUpdateRequest extends EventUpdateRequestDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    @Builder
    public HashtagEventUpdateRequest(String title, Integer status, Date startDate, Date finishDate, List<String> images, List<Reward> rewards,
                                     List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, status, startDate, finishDate, images, rewards);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }
}
