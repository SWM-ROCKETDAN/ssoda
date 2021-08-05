package com.rocketdan.serviceserver.domain.event.type;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DiscriminatorValue("hashtag")
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
    public Hashtag(String title, Integer status, Date startDate, Date finishDate, List<String> images, Store store,
                   List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, status, startDate, finishDate, images, store);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }

    public void update(String title, Integer status, Date startDate, Date finishDate, List<String> images,
                  List<String> hashtags, List<Boolean> requirements, Integer template) {
        super.update(title, status, startDate, finishDate, images);
        Optional.ofNullable(hashtags).ifPresent(none -> this.hashtags = hashtags);
        Optional.ofNullable(requirements).ifPresent(none -> this.requirements = requirements);
        Optional.ofNullable(template).ifPresent(none -> this.template = template);
    }
}
