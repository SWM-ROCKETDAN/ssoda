package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.user.LoginRequestDto;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.user.UserPrincipal;
import com.rocketdan.serviceserver.provider.security.JwtAuthToken;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

// /auth 라는 Path는 스프링 시큐리티 컨텍스트 내에 존재하는 인증절차를 거쳐 통과해야한다.
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

//    private final AppProperties appProperties;
    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final AuthenticationManager authenticationManager;
//    private final UserRefreshTokenRepository userRefreshTokenRepository;

    private final static long THREE_DAYS_MSEC = 259200000;
    private final static String REFRESH_TOKEN = "refresh_token";

    @PostMapping("/login")
    public ResponseEntity<CommonResponse> login(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestBody LoginRequestDto loginRequestDto
    ) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequestDto.getId(),
                        loginRequestDto.getPassword()
                )
        );

        String userId = loginRequestDto.getId();
        SecurityContextHolder.getContext().setAuthentication(authentication);

        Date expiredDate = Date.from(LocalDateTime.now().plusMinutes(THREE_DAYS_MSEC).atZone(ZoneId.systemDefault()).toInstant());

        JwtAuthToken accessToken = jwtAuthTokenProvider.createAuthToken(
                userId,
                ((UserPrincipal) authentication.getPrincipal()).getRole().getCode(),
                expiredDate);

//        long refreshTokenExpiry = appProperties.getAuth().getRefreshTokenExpiry();
//        AuthToken refreshToken = tokenProvider.createAuthToken(
//                appProperties.getAuth().getTokenSecret(),
//                new Date(now.getTime() + refreshTokenExpiry)
//        );

        // userId refresh token 으로 DB 확인
//        UserRefreshToken userRefreshToken = userRefreshTokenRepository.findByUserId(userId);
//        if (userRefreshToken == null) {
//            // 없는 경우 새로 등록
//            userRefreshToken = new UserRefreshToken(userId, refreshToken.getToken());
//            userRefreshTokenRepository.saveAndFlush(userRefreshToken);
//        } else {
//            // DB에 refresh 토큰 업데이트
//            userRefreshToken.setRefreshToken(refreshToken.getToken());
//        }

//        int cookieMaxAge = (int) refreshTokenExpiry / 60;
//        CookieUtil.deleteCookie(request, response, REFRESH_TOKEN);
//        CookieUtil.addCookie(response, REFRESH_TOKEN, refreshToken.getToken(), cookieMaxAge);

        // auth-token을 헤더에 전달
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("token", accessToken.getToken());

        return ResponseEntity.ok()
                .headers(responseHeaders)
                .body(CommonResponse.builder()
                        .code("LOGIN_SUCCESS")
                        .status(200)
                        .message(userId)
//                        .message(optionalLoginDto.get().getId().toString())
                        .build()
                );
    }
/*
    @GetMapping("/refresh")
    public ApiResponse refreshToken (HttpServletRequest request, HttpServletResponse response) {
        // access token 확인
        String accessToken = HeaderUtil.getAccessToken(request);
        AuthToken authToken = tokenProvider.convertAuthToken(accessToken);
        if (!authToken.validate()) {
            return ApiResponse.invalidAccessToken();
        }

        // expired access token 인지 확인
        Claims claims = authToken.getExpiredTokenClaims();
        if (claims == null) {
            return ApiResponse.notExpiredTokenYet();
        }

        String userId = claims.getSubject();
        RoleType roleType = RoleType.of(claims.get("role", String.class));

        // refresh token
        String refreshToken = CookieUtil.getCookie(request, REFRESH_TOKEN)
                .map(Cookie::getValue)
                .orElse((null));
        AuthToken authRefreshToken = tokenProvider.convertAuthToken(refreshToken);

        if (authRefreshToken.validate()) {
            return ApiResponse.invalidRefreshToken();
        }

        // userId refresh token 으로 DB 확인
        UserRefreshToken userRefreshToken = userRefreshTokenRepository.findByUserIdAndRefreshToken(userId, refreshToken);
        if (userRefreshToken == null) {
            return ApiResponse.invalidRefreshToken();
        }

        Date now = new Date();
        AuthToken newAccessToken = tokenProvider.createAuthToken(
                userId,
                roleType.getCode(),
                new Date(now.getTime() + appProperties.getAuth().getTokenExpiry())
        );

        long validTime = authRefreshToken.getTokenClaims().getExpiration().getTime() - now.getTime();

        // refresh 토큰 기간이 3일 이하로 남은 경우, refresh 토큰 갱신
        if (validTime <= THREE_DAYS_MSEC) {
            // refresh 토큰 설정
            long refreshTokenExpiry = appProperties.getAuth().getRefreshTokenExpiry();

            authRefreshToken = tokenProvider.createAuthToken(
                    appProperties.getAuth().getTokenSecret(),
                    new Date(now.getTime() + refreshTokenExpiry)
            );

            // DB에 refresh 토큰 업데이트
            userRefreshToken.setRefreshToken(authRefreshToken.getToken());

            int cookieMaxAge = (int) refreshTokenExpiry / 60;
            CookieUtil.deleteCookie(request, response, REFRESH_TOKEN);
            CookieUtil.addCookie(response, REFRESH_TOKEN, authRefreshToken.getToken(), cookieMaxAge);
        }

        return ApiResponse.success("token", newAccessToken.getToken());
    }*/
}

