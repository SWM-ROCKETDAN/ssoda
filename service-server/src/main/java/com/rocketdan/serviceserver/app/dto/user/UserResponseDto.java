package com.rocketdan.serviceserver.app.dto.user;

import com.rocketdan.serviceserver.domain.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserResponseDto {
    private Long id;
    private String userId;
    private String name;
    private String email;
    private String picture;

    public UserResponseDto(User entity) {
        this.id = entity.getId();
        this.userId = entity.getUserId();
        this.name = entity.getName();
        this.email = entity.getEmail();
        this.picture = entity.getPicture();
    }
}
