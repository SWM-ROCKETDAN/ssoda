package com.rocketdan.serviceserver.domain.event.detail;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
public class Hashtag extends DetailByType {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private int template;

    @Builder
    public Hashtag(List<String> hashtags, List<Boolean> requirements, int template) {
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }
}
