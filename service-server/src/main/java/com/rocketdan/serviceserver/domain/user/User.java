package com.rocketdan.serviceserver.domain.user;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import net.minidev.json.annotate.JsonIgnore;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String userId;

    @JsonIgnore
    @Column(nullable = false)
    private String password;

    private String name;

    @Column(nullable = false)
    private String email;

    @Column
    private String picture;

    // @Enumerated(EnumType.STRING)
    // * JPA로 데이터베이스로 저장할 때 Enum값을 어떤 형태로 저장할지 결정
    // * 기본적으로는 int로 된 숫자가 저장된다.
    // * 숫자가 저장되면 데이터베이스로 확인할 때 그 값이 무슨 코드를 의미하는지 알 수 없다.
    // * 그래서 문자열로 저장될 수 있도록 선언한 것.
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Store> stores;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Provider provider;

    @Column(nullable = false)
    private Date createdDate;

    @Column(nullable = false)
    private Date modifiedDate;

    @Builder
    public User(String userId, String password, String name, String email, String picture, Role role, List<Store> stores, Provider provider, Date createdDate, Date modifiedDate) {
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

    public void setModifiedDate(Date date) {
        this.modifiedDate = date;
    }

    public String getRoleCode() {
        return this.role.getCode();
    }
}
