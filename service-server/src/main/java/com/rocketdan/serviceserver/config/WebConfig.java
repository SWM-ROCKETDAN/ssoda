package com.rocketdan.serviceserver.config;

import com.rocketdan.serviceserver.provider.security.AuthInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// LoginUserArgumentResolver가 스프링에서 인식될 수 있도록 WebMvcConfigurer에 추가
@RequiredArgsConstructor
@Configuration
public class WebConfig implements WebMvcConfigurer {
    private final AuthInterceptor authInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                // 반드시 인증&인가를 통과한 후 접근할 수 있다.
                .addPathPatterns("api/v1/users/**", "/api/v1/events/hashtag/**", "/api/v1/stores/**", "/api/v1/rewards/**")
                // /api/v1/login/** 으로의 유입은 인터셉터를 거치지 않는다. (로그인 시도는 인증에 상관없이 가능하다,)
                .excludePathPatterns("api/v1/login/**", "/api/v1/events/{id}");
    }
}
