package com.rocketdan.serviceserver.app.dto.user;

import lombok.Getter;

@Getter
public class LoginRequestDto {
    private String name;
    private String email;
    private String picture;
}
