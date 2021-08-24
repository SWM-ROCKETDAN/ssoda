package com.rocketdan.serviceserver.provider.security;

import com.rocketdan.serviceserver.Exception.auth.CustomAuthenticationException;
import com.rocketdan.serviceserver.core.security.TokenUserEmail;
import com.rocketdan.serviceserver.domain.user.Role;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Component
public class UserEmailDecodeResolver implements HandlerMethodArgumentResolver {
    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private static final String AUTHORIZATION_HEADER = "x-auth-token";

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        boolean isTokenMemberEmail = parameter
                .getParameterAnnotation(TokenUserEmail.class) != null;

        boolean isString = String.class.equals(parameter.getParameterType());

        // TokenMemberEmail Annotation 과 파라미터의 타입이 String일 경우에만 resolveArgument를 수행
        return isTokenMemberEmail && isString;
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest, WebDataBinderFactory binderFactory)
            throws Exception {
        Optional<String> token = resolveToken(webRequest);

        if (token.isPresent()) {
            // 유효한 사용자인지(유효한 토큰인지) 검증 -> 인증
            // 리소스에 대한 권한이 있는지 검증 -> 인가
            JwtAuthToken jwtAuthToken = jwtAuthTokenProvider.convertAuthToken(token.get());
            if(jwtAuthToken.validate() & Role.USER.getCode().equals(jwtAuthToken.getData().get("role"))) {
                log.info(jwtAuthToken.getData().getSubject());
                // 컨트롤러에 user email 정보 전달
                return jwtAuthToken.getData().getSubject();
            }
            else {
                throw new CustomAuthenticationException();
            }
        } else {
            throw new CustomAuthenticationException();
        }
    }

    private Optional<String> resolveToken(NativeWebRequest request) {
        String authToken = request.getHeader(AUTHORIZATION_HEADER);
        if (StringUtils.hasText(authToken)) {
            return Optional.of(authToken);
        } else {
            return Optional.empty();
        }
    }
}
