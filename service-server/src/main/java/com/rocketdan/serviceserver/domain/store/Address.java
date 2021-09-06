package com.rocketdan.serviceserver.domain.store;

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
    @Column(nullable = false)
    private String city;

    // 시군구명
    @Column(nullable = false)
    private String country;

    // 읍면동명
    @Column(nullable = false)
    private String town;

    // 도로명
    @Column(nullable = false)
    private String road;

    // 우편 번호
    @Column(nullable = false)
    private String zipCode;

    // 건물 번호
    @Column(nullable = false)
    private String buildingCode;

    // 위도
    private Double latitude;

    // 경도
    private Double longitude;

    @Builder
    public Address(String city, String country, String town, String road, String zipCode, String buildingCode, Double latitude, Double longitude) {
        this.city = city;
        this.country = country;
        this.town = town;
        this.road = road;
        this.zipCode = zipCode;
        this.buildingCode = buildingCode;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}
