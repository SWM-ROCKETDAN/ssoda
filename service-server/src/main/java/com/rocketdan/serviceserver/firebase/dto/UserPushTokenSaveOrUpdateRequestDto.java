package com.rocketdan.serviceserver.firebase.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class UserPushTokenSaveOrUpdateRequestDto {
    private String pushToken;

    @Builder
    public UserPushTokenSaveOrUpdateRequestDto(String pushToken) {
        this.pushToken = pushToken;
    }
}
