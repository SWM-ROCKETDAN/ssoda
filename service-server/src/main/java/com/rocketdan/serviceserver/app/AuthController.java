package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.auth.token.CustomRefreshTokenException;
import com.rocketdan.serviceserver.Exception.auth.token.NoExpiredTokenYetException;
import com.rocketdan.serviceserver.app.dto.auth.RefreshTokenResponseDto;
import com.rocketdan.serviceserver.app.dto.user.LoginRequestDto;
import com.rocketdan.serviceserver.config.properties.AppProperties;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.domain.user.UserPrincipal;
import com.rocketdan.serviceserver.provider.security.JwtAuthToken;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import com.rocketdan.serviceserver.service.UserRefreshTokenService;
import com.rocketdan.serviceserver.utils.CookieUtil;
import com.rocketdan.serviceserver.utils.HeaderUtil;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

// /auth 라는 Path는 스프링 시큐리티 컨텍스트 내에 존재하는 인증절차를 거쳐 통과해야한다.
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AppProperties appProperties;
    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final AuthenticationManager authenticationManager;
    private final UserRefreshTokenService userRefreshTokenService;

    private final static String HEADER_AUTHORIZATION = "Authorization";
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

        Date now = new Date();

        JwtAuthToken accessToken = jwtAuthTokenProvider.createAuthToken(
                userId,
                ((UserPrincipal) authentication.getPrincipal()).getRole().getCode(),
                new Date(now.getTime() + appProperties.getAuth().getTokenExpiry()));

        long refreshTokenExpiry = appProperties.getAuth().getRefreshTokenExpiry();
        JwtAuthToken refreshToken = jwtAuthTokenProvider.createAuthToken(
                appProperties.getAuth().getTokenSecret(),
                new Date(now.getTime() + refreshTokenExpiry)
        );

        // userId refresh token 으로 DB 확인
        userRefreshTokenService.saveOrUpdate(userId, refreshToken.getToken());

        // access token을 헤더에 전달
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set(HEADER_AUTHORIZATION, accessToken.getToken());

        // refresh token을 쿠키로 전달
        int cookieMaxAge = (int) refreshTokenExpiry / 60;
        CookieUtil.deleteCookie(request, response, REFRESH_TOKEN);
        CookieUtil.addCookie(response, REFRESH_TOKEN, refreshToken.getToken(), cookieMaxAge);

        return ResponseEntity.ok()
                .headers(responseHeaders)
                .body(CommonResponse.builder()
                        .message("Successfully logged in.")
                        .code("LOGIN_SUCCESS")
                        .status(200)
                        .data(userId)
                        .build()
                );
    }

    @GetMapping("/refresh")
    public ResponseEntity<CommonResponse> refreshToken(HttpServletRequest request, HttpServletResponse response) {
        // access token 확인
        String accessToken = HeaderUtil.getAccessToken(request);
        JwtAuthToken authToken = jwtAuthTokenProvider.convertAuthToken(accessToken);

        try {
            authToken.validate();
        } catch (ExpiredJwtException e) {
            // ignore
        }

        // expired access token 인지 확인
        Claims claims = authToken.getExpiredData();
        if (claims == null) {
            throw new NoExpiredTokenYetException();
        }

        String userId = claims.getSubject();
        Role role = Role.of(claims.get("role", String.class));

        // refresh token
        String refreshToken = CookieUtil.getCookie(request, REFRESH_TOKEN)
                .map(Cookie::getValue)
                .orElse((null));
        JwtAuthToken authRefreshToken = jwtAuthTokenProvider.convertAuthToken(refreshToken);

        try {
            authRefreshToken.validate();
        } catch (ExpiredJwtException e) {
            throw new CustomRefreshTokenException();
        }

        // refresh token DB 확인
        if (!userRefreshTokenService.checkValid(userId, refreshToken)) {
            throw new CustomRefreshTokenException();
        }

        Date now = new Date();
        JwtAuthToken newAccessToken = jwtAuthTokenProvider.createAuthToken(
                userId,
                role.getCode(),
                new Date(now.getTime() + appProperties.getAuth().getTokenExpiry())
        );

        long validTime = authRefreshToken.getData().getExpiration().getTime() - now.getTime();

        // refresh 토큰 기간이 3일 이하로 남은 경우, refresh 토큰 갱신
        if (validTime <= THREE_DAYS_MSEC) {
            // refresh 토큰 설정
            long refreshTokenExpiry = appProperties.getAuth().getRefreshTokenExpiry();

            authRefreshToken = jwtAuthTokenProvider.createAuthToken(
                    appProperties.getAuth().getTokenSecret(),
                    new Date(now.getTime() + refreshTokenExpiry)
            );

            // DB에 refresh 토큰 업데이트
            userRefreshTokenService.update(userId, authRefreshToken.getToken());
        }

        // access token을 헤더에 전달
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set(HEADER_AUTHORIZATION, newAccessToken.getToken());

        return ResponseEntity.ok()
                .headers(responseHeaders)
                .body(CommonResponse.builder()
                        .message("Successfully generate token.")
                        .code("GENERATE_TOKEN_SUCCESS")
                        .status(200)
                        .data(new RefreshTokenResponseDto(authRefreshToken.getToken()))
                        .build()
                );
    }
}

