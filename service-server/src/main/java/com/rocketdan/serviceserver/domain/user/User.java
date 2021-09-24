package com.rocketdan.serviceserver.domain.user;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import net.minidev.json.annotate.JsonIgnore;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SQLDelete(sql = "UPDATE user SET deleted = true WHERE id = ?")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String userId;

    @JsonIgnore
    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String name;

    private String email;

    private String picture;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Store> stores;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Provider provider;

    @Column(nullable = false)
    private LocalDateTime createdDate;

    @Column(nullable = false)
    private LocalDateTime modifiedDate;

    @ColumnDefault("false")
    @Column(nullable = false)
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
