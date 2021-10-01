package com.rocketdan.serviceserver.domain.event.type;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.RewardPolicy;
import com.rocketdan.serviceserver.domain.reward.Reward;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
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
    @Size(max = 10)
    private List<String> hashtags;

    @ElementCollection
    @Column(nullable = false, columnDefinition = "TINYINT")
    private List<Boolean> requirements;

    @Column(nullable = false)
    private Integer template;

    @Builder
    public Hashtag(String title, RewardPolicy rewardPolicy, Integer status, LocalDateTime startDate, LocalDateTime finishDate, List<String> images, List<Reward> rewards, Store store,
                   List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, rewardPolicy, status, startDate, finishDate, images, rewards, store);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }

    public void update(String title, LocalDateTime startDate, LocalDateTime finishDate, List<String> images,
                  List<String> hashtags, List<Boolean> requirements, Integer template) {
        super.update(title, startDate, finishDate, images);
        Optional.ofNullable(hashtags).ifPresent(none -> this.hashtags = hashtags);
        Optional.ofNullable(requirements).ifPresent(none -> this.requirements = requirements);
        Optional.ofNullable(template).ifPresent(none -> this.template = template);
    }
}
