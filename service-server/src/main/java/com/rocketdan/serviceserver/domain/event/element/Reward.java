package com.rocketdan.serviceserver.domain.event.element;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class Reward {
    private int category;
    private String name;
    private String image;
    private int price;
    private int count;
}