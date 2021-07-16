package com.rocketdan.serviceserver.domain.store;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Store {
    // 가게 id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // private String user_id;

    // 가게 이름
    @Column(nullable = false)
    private String name;

    // 가게 분류
    @Column(nullable = false)
    private Integer category;

    // 가게 주소
    @Embedded
    private Address address;

    // 가게 상세 설명
    @Column(columnDefinition = "TEXT")
    private String description;

    // 가게 이미지
    @ElementCollection
    private List<String> images;

    // 가게에서 개설한 이벤트 목록
    @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL)
    private List<Event> events;

    @Builder
    public Store(String name, Integer category, Address address, String description, List<String> images, List<Event> events) {
        this.name = name;
        this.category = category;
        this.address = address;
        this.description = description;
        this.images = images;
        this.events = events;
    }
}
