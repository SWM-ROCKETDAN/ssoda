package com.rocketdan.serviceserver.firebase.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class UserPushTokenSaveRequestDto {
    private String pushToken;

    @Builder
    public UserPushTokenSaveRequestDto(String pushToken) {
        this.pushToken = pushToken;
    }
}
