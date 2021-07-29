package com.rocketdan.serviceserver.core.service;

import com.rocketdan.serviceserver.app.dto.user.UserResponseDto;
import com.rocketdan.serviceserver.core.security.AuthToken;

import java.util.Optional;

public interface LoginUseCase {
    Optional<UserResponseDto> login(String email);
    AuthToken createAuthToken(UserResponseDto userResponseDto);
}
