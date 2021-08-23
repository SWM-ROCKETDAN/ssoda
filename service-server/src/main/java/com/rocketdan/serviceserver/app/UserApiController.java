package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.core.security.TokenUserEmail;
import com.rocketdan.serviceserver.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/my")
public class UserApiController {
    private final UserService userService;

    @GetMapping("/stores")
    public List<StoreListResponseDto> retrieveStoreListById(@TokenUserEmail String email) { return userService.getStoreListById(email); }
}
