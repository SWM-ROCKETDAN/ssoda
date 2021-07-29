package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import lombok.Getter;

import java.util.List;

@Getter
public class HashtagEventResponseDto extends EventResponseDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    public HashtagEventResponseDto (Hashtag entity) {
        super(entity);
        this.hashtags = List.copyOf(entity.getHashtags());
        this.requirements = List.copyOf(entity.getRequirements());
        this.template = entity.getTemplate();
    }
}
