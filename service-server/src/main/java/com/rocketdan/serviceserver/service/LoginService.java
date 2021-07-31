package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.user.LoginDto;
import com.rocketdan.serviceserver.app.dto.user.LoginRequestDto;
import com.rocketdan.serviceserver.core.security.AuthToken;
import com.rocketdan.serviceserver.core.service.LoginUseCase;
import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.domain.user.User;
import com.rocketdan.serviceserver.domain.user.UserRepository;
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
    private final UserRepository userRepository;

    @Override
    public Optional<LoginDto> login(LoginRequestDto loginRequestDto) {
        User user = saveOrUpdate(loginRequestDto);

        LoginDto loginDto = LoginDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(Role.USER)
                .build();

        return Optional.ofNullable(loginDto);
    }

    @Override
    public AuthToken createAuthToken(LoginDto loginDto) {

        Date expiredDate = Date.from(LocalDateTime.now().plusMinutes(LOGIN_RETENTION_MINUTES).atZone(ZoneId.systemDefault()).toInstant());
        return jwtAuthTokenProvider.createAuthToken(loginDto.getEmail(), loginDto.getRole().getCode(), expiredDate);
    }

    private User saveOrUpdate(LoginRequestDto loginRequestDto) {
        User user = userRepository.findByEmail(loginRequestDto.getEmail())
                .map(entity -> entity.update(loginRequestDto.getName(), loginRequestDto.getPicture()))
                .orElse(loginRequestDto.toEntity());

        return userRepository.save(user);
    }
}
