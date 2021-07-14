package com.rocketdan.serviceserver.domain.event.type;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DiscriminatorValue("Hashtag")
public class Hashtag extends Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ElementCollection
    private List<String> hashtags;

    @ElementCollection
    @Column(nullable = false)
    private List<Boolean> requirements;

    @Column(nullable = false)
    private Integer template;

    @Builder
    public Hashtag(String title, int status, Date startDate, Date finishDate, List<String> images, List<Reward> rewards, List<String> hashtags, List<Boolean> requirements, int template) {
        super(title, status, startDate, finishDate, images, rewards);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }
}
