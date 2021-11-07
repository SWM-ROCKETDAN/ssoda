package com.rocketdan.serviceserver.domain.store;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.user.User;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.List;
import java.util.Optional;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SQLDelete(sql = "UPDATE store SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
public class Store {
    // 가게 id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private User user;

    // 가게 이름
    @Size(max = 20)
    @Column(nullable = false, length = 20)
    private String name;

    // 가게 분류
    @Column(nullable = false)
    private Integer category;

    // 가게 주소
    @Embedded
    private Address address;

    // 가게 상세 설명
    @Size(max = 100)
    @Column(columnDefinition = "TEXT", length = 100)
    private String description;

    // 가게 이미지
    @ElementCollection
    private List<String> imagePaths;

    // 가게 로고 이미지
    private String logoImagePath;

    // 가게에서 개설한 이벤트 목록
    @OneToMany(mappedBy = "store", cascade = CascadeType.REMOVE)
    private List<Event> events;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

    @Builder
    public Store(String name, User user, Integer category, Address address, String description, List<String> imagePaths, String logoImagePath, List<Event> events) {
        this.name = name;
        this.user = user;
        this.category = category;
        this.address = address;
        this.description = description;
        this.imagePaths = imagePaths;
        this.logoImagePath = logoImagePath;
        this.events = events;
    }

    public void update(String name, Integer category, Address address, String description, List<String> imagePaths, String logoImagePath) {
        Optional.ofNullable(name).ifPresent(none -> this.name = name);
        Optional.ofNullable(category).ifPresent(none -> this.category = category);
        this.address = address;
        this.description = description;
        this.imagePaths = imagePaths;
        this.logoImagePath = logoImagePath;
    }

    public void setUser(User user) {
        this.user = user;

        if (!user.getStores().contains(this)) {
            user.getStores().add(this);
        }
    }
}
