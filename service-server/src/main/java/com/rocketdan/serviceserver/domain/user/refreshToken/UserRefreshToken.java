package com.rocketdan.serviceserver.domain.user.refreshToken;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class UserRefreshToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 80)
    private String userId;

    @Column(nullable = false)
    private String refreshToken;

    public UserRefreshToken(String userId, String refreshToken) {
        this.userId = userId;
        this.refreshToken = refreshToken;
    }

    public void updateRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
}
