package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Getter
public class HashtagEventUpdateRequest extends EventUpdateRequestDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    @Builder
    public HashtagEventUpdateRequest(String title, Integer status, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date startDate, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date finishDate, List<String> images,
                                     List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, status, startDate, finishDate, images);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }
}
