package com.rocketdan.serviceserver.domain.reward;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
public class Reward {
    @Id
    @JsonIgnore
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Event event;

    @Column(nullable = false)
    private Integer level;

    private Integer category;

    @Column(nullable = false)
    private String name;

    private String image;

    @Column(nullable = false)
    private Integer price;

    @Column(nullable = false)
    private Integer count;

    // 소모된 수량
    private Integer usedCount;

    @Builder
    public Reward(Event event, Integer level, Integer category, String name, String image, Integer price, Integer count, Integer usedCount) {
        this.event = event;
        this.level = level;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
        this.usedCount = usedCount;
    }

    public void setEvent(Event event) {
        this.event = event;

        if (!event.getRewards().contains(this)) {
            event.getRewards().add(this);
        }
    }
}