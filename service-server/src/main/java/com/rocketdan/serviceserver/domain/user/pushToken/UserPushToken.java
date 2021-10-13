package com.rocketdan.serviceserver.domain.user.pushToken;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

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

    @ColumnDefault("true")
    @Column(nullable = true, columnDefinition = "TINYINT")
    private Boolean allowed = true;

    @Builder
    public UserPushToken(String userId, String pushToken) {
        this.userId = userId;
        this.pushToken = pushToken;
    }

    public void updatePushToken(String pushToken) {
        this.pushToken = pushToken;
    }

    public void updateAllowed(boolean allowed) {
        this.allowed = allowed;
    }
}
