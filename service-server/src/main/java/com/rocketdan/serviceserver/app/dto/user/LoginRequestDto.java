package com.rocketdan.serviceserver.app.dto.user;

import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.domain.user.User;
import lombok.Getter;

@Getter
public class LoginRequestDto {
    private String id;
    private String password;

    public User toEntity() {
        return User.builder()
                .userId(id)
                .password(password)
                .role(Role.USER)
                .build();
    }
}
