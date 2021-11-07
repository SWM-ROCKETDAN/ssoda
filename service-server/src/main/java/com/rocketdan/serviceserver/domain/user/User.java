package com.rocketdan.serviceserver.domain.user;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import net.minidev.json.annotate.JsonIgnore;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SQLDelete(sql = "UPDATE user SET deleted = true WHERE id = ?")
public class User {
    // id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // user의 ID
    @Size(max = 80)
    @Column(nullable = false, unique = true, length = 80)
    private String userId;

    // 비밀번호
    @JsonIgnore
    @Size(max = 80)
    @Column(nullable = false, length = 80)
    private String password;

    // 이름
    @Size(max = 30)
    @Column(nullable = false, length = 30)
    private String name;

    // 이메일
    @Size(max = 80)
    private String email;

    // 사진
    private String picture;

    // ROLE
    @Size(max = 10)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Role role;

    // 가게 list
    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Store> stores;

    // Social 로그인 제공자
    @Size(max = 10)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Provider provider;

    // 생성 시각
    @Column(nullable = false)
    private LocalDateTime createdDate;

    // 수정 시각
    @Column(nullable = false)
    private LocalDateTime modifiedDate;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

    @Builder
    public User(String userId, String password, String name, String email, String picture, Role role, List<Store> stores, Provider provider, LocalDateTime createdDate, LocalDateTime modifiedDate) {
        this.userId = userId;
        this.password = password;
        this.name = name;
        this.email = email;
        this.picture = picture;
        this.role = role;
        this.stores = stores;
        this.provider = provider;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public void setModifiedDate(LocalDateTime date) {
        this.modifiedDate = date;
    }

    public void rejoin() { this.deleted = false; }

    public String getRoleCode() {
        return this.role.getCode();
    }
}
