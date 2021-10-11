package com.rocketdan.serviceserver.firebase.dto;

import com.rocketdan.serviceserver.domain.user.pushToken.UserPushToken;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserPushTokenResponseDto {
    String pushToken;

    public UserPushTokenResponseDto(UserPushToken userPushToken) {
        this.pushToken = userPushToken.getPushToken();
    }
}
