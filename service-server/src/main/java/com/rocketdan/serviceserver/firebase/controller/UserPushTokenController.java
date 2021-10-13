package com.rocketdan.serviceserver.firebase.controller;

import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.firebase.dto.UserPushTokenAllowedUpdateRequestDto;
import com.rocketdan.serviceserver.firebase.dto.UserPushTokenSaveOrUpdateRequestDto;
import com.rocketdan.serviceserver.firebase.service.UserPushTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/users/me/push")
public class UserPushTokenController {
    private final UserPushTokenService userPushTokenService;

    @PutMapping()
    public void saveOrUpdate(@RequestBody UserPushTokenSaveOrUpdateRequestDto request, @LoginUser org.springframework.security.core.userdetails.User principal) {
        userPushTokenService.saveOrUpdate(principal.getUsername(), request);
    }

    @PutMapping("/allowed")
    public void updateAllowed(@RequestBody UserPushTokenAllowedUpdateRequestDto request, @LoginUser org.springframework.security.core.userdetails.User principal) {
        userPushTokenService.updateAllowed(principal.getUsername(), request);
    }
}
