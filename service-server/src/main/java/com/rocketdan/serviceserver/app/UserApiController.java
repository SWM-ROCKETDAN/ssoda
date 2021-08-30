package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.user.UserResponseDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/users")
public class UserApiController {
    private final UserService userService;

    @GetMapping("/me/stores")
    public List<StoreListResponseDto> retrieveStoreListById(@LoginUser org.springframework.security.core.userdetails.User principal) {
        return userService.getStoreListById(principal.getUsername());
    }

    @GetMapping("/me")
    public UserResponseDto retrieveMyInfo(@LoginUser org.springframework.security.core.userdetails.User principal) {
        return userService.findByUserId(principal.getUsername());
    }

    @DeleteMapping("/me")
    public void delete(@LoginUser org.springframework.security.core.userdetails.User principal) {
        userService.delete(principal.getUsername());;
    }
}
