package com.rocketdan.serviceserver.core.service;

import com.rocketdan.serviceserver.app.dto.user.LoginDto;
import com.rocketdan.serviceserver.app.dto.user.LoginRequestDto;
import com.rocketdan.serviceserver.core.security.AuthToken;

import java.util.Optional;

public interface LoginUseCase {
    Optional<LoginDto> login(LoginRequestDto loginRequestDto);
    AuthToken createAuthToken(LoginDto loginDto);
}
