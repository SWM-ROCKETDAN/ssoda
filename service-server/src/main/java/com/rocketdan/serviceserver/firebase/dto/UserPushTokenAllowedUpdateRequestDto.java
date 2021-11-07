package com.rocketdan.serviceserver.firebase.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class UserPushTokenAllowedUpdateRequestDto {
    private Boolean allowed;

    @Builder
    public UserPushTokenAllowedUpdateRequestDto(Boolean allowed) {
        this.allowed = allowed;
    }
}
