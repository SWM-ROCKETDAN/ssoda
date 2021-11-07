package com.rocketdan.serviceserver.app.dto.auth;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class RefreshTokenResponseDto {
    private String refreshToken;

    public RefreshTokenResponseDto(String refreshToken) {
        this.refreshToken = refreshToken;
    }
}
