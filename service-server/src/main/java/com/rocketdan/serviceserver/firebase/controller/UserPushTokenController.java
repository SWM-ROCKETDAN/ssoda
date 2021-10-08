package com.rocketdan.serviceserver.firebase.controller;

import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.firebase.dto.UserPushTokenSaveRequestDto;
import com.rocketdan.serviceserver.firebase.service.UserPushTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/users/me/push")
public class UserPushTokenController {
    private final UserPushTokenService userPushTokenService;

    @PutMapping()
    public void saveOrUpdate(UserPushTokenSaveRequestDto request, @LoginUser org.springframework.security.core.userdetails.User principal) {
        userPushTokenService.saveOrUpdate(principal.getUsername(), request);
    }
}
