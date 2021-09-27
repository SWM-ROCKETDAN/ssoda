package com.rocketdan.serviceserver.oauth.filter;

import com.rocketdan.serviceserver.Exception.auth.CustomJwtRuntimeException;
import com.rocketdan.serviceserver.provider.security.JwtAuthToken;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import com.rocketdan.serviceserver.utils.HeaderUtil;
import io.jsonwebtoken.ExpiredJwtException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
public class TokenAuthenticationFilter extends OncePerRequestFilter {

    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final List<String> excludeUrlPatternsGET = List.of("/api/v1/events/**", "/api/v1/stores/**", "**login**", "/favicon.ico");
    private final List<String> excludeUrlPatternsPOST = List.of("/api/v1/join/events/**");
    private final List<String> excludeUrlPatternsPUT = List.of("/api/v1/join/posts/**");

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        String path = request.getServletPath();
        switch (request.getMethod()) {
            case "GET":
                return excludeUrlPatternsGET.stream().anyMatch(pattern -> new AntPathMatcher().match(pattern, path));
            case "POST":
                return excludeUrlPatternsPOST.stream().anyMatch(pattern -> new AntPathMatcher().match(pattern, path));
            case "PUT":
                return excludeUrlPatternsPUT.stream().anyMatch(pattern -> new AntPathMatcher().match(pattern, path));
        }
        return false;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain)  throws ServletException, IOException {

        String path = request.getRequestURI();
        String contentType = request.getContentType();
        log.info("Request URL path : {}, Request content type: {}", path, contentType);

        String tokenStr = HeaderUtil.getAccessToken(request);
        JwtAuthToken token = jwtAuthTokenProvider.convertAuthToken(tokenStr);

        try {
            if (token.validate()) {
                Authentication authentication = jwtAuthTokenProvider.getAuthentication(token);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        } catch (ExpiredJwtException e) {
            String refreshApiPath = "/api/v1/auth/refresh";
            if (!path.equals(refreshApiPath)) {
                throw new CustomJwtRuntimeException();
            }
        }

        filterChain.doFilter(request, response);
    }
}

