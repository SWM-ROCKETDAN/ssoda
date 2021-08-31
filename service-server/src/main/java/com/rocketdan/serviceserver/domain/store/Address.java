package com.rocketdan.serviceserver.domain.store;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor
public class Address {
    // 시도명
    private String city;

    // 시군구명
    private String country;

    // 읍면동명
    private String town;

    // 도로명 코드
    @Column(length = 12)
    private String roadCode;

    // 도로명
    private String road;

    // 우편 번호
    private String zipCode;

    @Builder
    public Address(String city, String country, String town, String roadCode, String road, String zipCode) {
        this.city = city;
        this.country = country;
        this.town = town;
        this.roadCode = roadCode;
        this.road = road;
        this.zipCode = zipCode;
    }
}
