package com.rocketdan.serviceserver.domain.user;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Getter
@NoArgsConstructor
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
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

    @Builder
    public User(String name, String email, String picture, Role role, List<Store> stores) {
        this.name = name;
        this.email = email;
        this.picture = picture;
        this.role = role;
        this.stores = stores;
    }

    public User update(String name, String picture) {
        this.name = name;
        this.picture = picture;

        return this;
    }

    public String getRoleCode() {
        return this.role.getCode();
    }
}
