package com.rocketdan.serviceserver.domain.reward;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
//@SQLDelete(sql = "UPDATE reward SET deleted = true WHERE id = ?")
//@Where(clause = "deleted = false")
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

    private String imagePath;

    @Column(nullable = false)
    private Integer price;

    @Column(nullable = false)
    private Integer count;

    // 소모된 수량
    @ColumnDefault("0")
    @Column(nullable = false)
    private Integer usedCount = 0;

//    @ColumnDefault("false")
//    @Column(nullable = false)
//    private Boolean deleted = false;

    @Builder
    public Reward(Event event, Integer level, Integer category, String name, String imagePath, Integer price, Integer count) {
        this.event = event;
        this.level = level;
        this.category = category;
        this.name = name;
        this.imagePath = imagePath;
        this.price = price;
        this.count = count;
    }

    public void setEvent(Event event) {
        this.event = event;

        if (!event.getRewards().contains(this)) {
            event.getRewards().add(this);
        }
    }
}