package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Builder;

import java.util.Date;
import java.util.List;

public class HashtagEventSaveRequest extends EventSaveRequestDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    @Builder
    public HashtagEventSaveRequest(String title, Date startDate, Date finishDate, List<Reward> rewards,
                                   List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, startDate, finishDate, rewards);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }

    // imgPaths는 나중에 주입받아야 하므로
    public Hashtag toEntity(List<String> imgPaths) {
        return Hashtag.builder()
                .title(super.getTitle())
                .startDate(super.getStartDate())
                .finishDate(super.getFinishDate())
                .images(imgPaths)
                .rewards(super.getRewards())
                .hashtags(hashtags)
                .requirements(requirements)
                .template(template)
                .build();
    }
}
