package com.rocketdan.serviceserver.domain.event.reward;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Optional;

@Entity
@Getter
//@AllArgsConstructor
@NoArgsConstructor
public class Reward {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer category;
    private String name;
    private String image;
    private Integer price;
    private Integer count;

    public Reward(Integer category, String name, String image, Integer price, Integer count) {
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
    }
}