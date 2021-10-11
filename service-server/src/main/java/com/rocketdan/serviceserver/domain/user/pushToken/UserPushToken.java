package com.rocketdan.serviceserver.domain.user.pushToken;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class UserPushToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 80)
    private String userId;

    @Column(nullable = false)
    private String pushToken;

    @Builder
    public UserPushToken(String userId, String pushToken) {
        this.userId = userId;
        this.pushToken = pushToken;
    }

    public void updatePushToken(String pushToken) {
        this.pushToken = pushToken;
    }
}
