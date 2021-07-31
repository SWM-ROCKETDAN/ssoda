package com.rocketdan.serviceserver.app.dto.user;

import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.domain.user.User;
import lombok.Getter;

@Getter
public class LoginRequestDto {
    private String name;
    private String email;
    private String picture;

    public User toEntity() {
        return User.builder()
                .name(name)
                .email(email)
                .picture(picture)
                .role(Role.USER)
                .build();
    }
}
