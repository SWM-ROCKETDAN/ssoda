package com.rocketdan.serviceserver.domain.reward;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Optional;

@Entity
@Getter
@NoArgsConstructor
@SQLDelete(sql = "UPDATE reward SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
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

    @Size(max = 20)
    @Column(nullable = false, length = 20)
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

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

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

    public void update(Integer level, Integer category, String name, String imagePath, Integer price, Integer count) {
        Optional.ofNullable(level).ifPresent(none -> this.level = level);
        this.category = category;
        Optional.ofNullable(name).ifPresent(none -> this.name = name);
        this.imagePath = imagePath;
        Optional.ofNullable(price).ifPresent(none -> this.price = price);
        Optional.ofNullable(count).ifPresent(none -> this.count = count);
    }

    public void setEvent(Event event) {
        this.event = event;

        if (!event.getRewards().contains(this)) {
            event.getRewards().add(this);
        }
    }

    public Integer increaseUsedCount() {
        this.usedCount += 1;
        return this.usedCount;
    }

    public void updateLevel(Integer level) {
        if (level != null) {
            this.level = level;
        }
    }
}