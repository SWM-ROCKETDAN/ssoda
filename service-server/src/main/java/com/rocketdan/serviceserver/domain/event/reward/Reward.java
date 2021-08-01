package com.rocketdan.serviceserver.domain.event.reward;

import com.fasterxml.jackson.annotation.JsonIgnore;
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

    private Long level;

    private Integer category;

    @Column(nullable = false)
    private String name;

    private String image;

    private Integer price;

    private Integer count;

    public Reward(Long level, Integer category, String name, String image, Integer price, Integer count) {
        this.level = level;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
    }
}