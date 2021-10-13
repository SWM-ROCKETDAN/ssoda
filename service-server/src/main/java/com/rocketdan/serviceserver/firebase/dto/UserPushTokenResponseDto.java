package com.rocketdan.serviceserver.firebase.dto;

import com.rocketdan.serviceserver.domain.user.pushToken.UserPushToken;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserPushTokenResponseDto {
    private String pushToken;
    private Boolean allowed;

    public UserPushTokenResponseDto(UserPushToken userPushToken) {
        this.pushToken = userPushToken.getPushToken();
        this.allowed = userPushToken.getAllowed();
    }
}
