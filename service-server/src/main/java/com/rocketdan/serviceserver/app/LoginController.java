package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.auth.LoginFailedException;
import com.rocketdan.serviceserver.app.dto.user.LoginDto;
import com.rocketdan.serviceserver.app.dto.user.LoginRequestDto;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.provider.security.JwtAuthToken;
import com.rocketdan.serviceserver.service.LoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/api/v1/login")
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;

    @PostMapping
    public ResponseEntity<CommonResponse> login(@RequestBody LoginRequestDto loginRequestDto) {

        Optional<LoginDto> optionalLoginDto = loginService.login(loginRequestDto);

        if (optionalLoginDto.isPresent()) {

            JwtAuthToken jwtAuthToken = (JwtAuthToken) loginService.createAuthToken(optionalLoginDto.get());

            // auth-token을 헤더에 전달
            HttpHeaders responseHeaders = new HttpHeaders();
            responseHeaders.set("x-auth-token", jwtAuthToken.getToken());

            return ResponseEntity.ok()
                    .headers(responseHeaders)
                    .body(CommonResponse.builder()
                            .code("LOGIN_SUCCESS")
                            .status(200)
                            .message(optionalLoginDto.get().getId().toString())
                            .build()

                    );

        } else {
            throw new LoginFailedException();
        }
    }
}
