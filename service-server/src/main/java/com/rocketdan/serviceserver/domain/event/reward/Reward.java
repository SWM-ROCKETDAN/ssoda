package com.rocketdan.serviceserver.domain.event.reward;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
//@AllArgsConstructor
@NoArgsConstructor
public class Reward {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int category;
    private String name;
    private String image;
    private int price;
    private int count;

    public Reward(int category, String name, String image, int price, int count) {
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
    }
}