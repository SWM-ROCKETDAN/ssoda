package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.user.UserResponseDto;
import com.rocketdan.serviceserver.core.security.TokenUserEmail;
import com.rocketdan.serviceserver.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/users")
public class UserApiController {
    private final UserService userService;

    @GetMapping("/my/stores")
    public List<StoreListResponseDto> retrieveStoreListById() {
        org.springframework.security.core.userdetails.User principal = (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userService.getStoreListById(principal.getUsername());
    }

    @GetMapping("/my")
    public UserResponseDto retrieveMyInfo() {
        org.springframework.security.core.userdetails.User principal = (org.springframework.security.core.userdetails.User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userService.findByUserId(principal.getUsername());
    }
}
