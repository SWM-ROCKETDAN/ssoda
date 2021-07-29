package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.user.UserResponseDto;
import com.rocketdan.serviceserver.core.security.AuthToken;
import com.rocketdan.serviceserver.core.service.LoginUseCase;
import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LoginService implements LoginUseCase {

    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final static long LOGIN_RETENTION_MINUTES = 30;

    @Override
    public Optional<UserResponseDto> login(String email) {

        //TODO: 로그인 연동

        //로그인 성공했다고 가정하고..
        UserResponseDto userResponseDto = UserResponseDto.builder()
                .name("eddy")
                .email(email)
                .role(Role.USER)
                .build();

        return Optional.ofNullable(userResponseDto);
    }

    //TODO: 네이밍
    @Override
    public AuthToken createAuthToken(UserResponseDto userResponseDto) {

        Date expiredDate = Date.from(LocalDateTime.now().plusMinutes(LOGIN_RETENTION_MINUTES).atZone(ZoneId.systemDefault()).toInstant());
        return jwtAuthTokenProvider.createAuthToken(userResponseDto.getEmail(), userResponseDto.getRole().getCode(), expiredDate);
    }
}
