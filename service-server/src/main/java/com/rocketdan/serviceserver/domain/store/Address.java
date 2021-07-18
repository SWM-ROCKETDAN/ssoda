package com.rocketdan.serviceserver.domain.store;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
@Getter
@AllArgsConstructor
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
}
