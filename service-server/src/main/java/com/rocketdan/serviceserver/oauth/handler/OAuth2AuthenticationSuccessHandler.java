package com.rocketdan.serviceserver.oauth.handler;

import com.rocketdan.serviceserver.config.properties.AppProperties;
import com.rocketdan.serviceserver.domain.user.Provider;
import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.oauth.info.OAuth2UserInfo;
import com.rocketdan.serviceserver.oauth.info.OAuth2UserInfoFactory;
import com.rocketdan.serviceserver.oauth.repository.OAuth2AuthorizationRequestBasedOnCookieRepository;
import com.rocketdan.serviceserver.provider.security.JwtAuthToken;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import com.rocketdan.serviceserver.service.UserRefreshTokenService;
import com.rocketdan.serviceserver.utils.CookieUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.util.Collection;
import java.util.Date;
import java.util.Optional;

import static com.rocketdan.serviceserver.oauth.repository.OAuth2AuthorizationRequestBasedOnCookieRepository.REDIRECT_URI_PARAM_COOKIE_NAME;

@Component
@RequiredArgsConstructor
public class OAuth2AuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final AppProperties appProperties;
    private final UserRefreshTokenService userRefreshTokenService;
    private final OAuth2AuthorizationRequestBasedOnCookieRepository authorizationRequestRepository;

    private final static String SUCCESS_COMMAND = "://success";

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        String targetUrl = determineTargetUrl(request, response, authentication);
        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
            return;
        }

        clearAuthenticationAttributes(request, response);
        getRedirectStrategy().sendRedirect(request, response, targetUrl);
    }

    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        Optional<String> redirectUri = CookieUtil.getCookie(request, REDIRECT_URI_PARAM_COOKIE_NAME)
                .map(Cookie::getValue);

        if(redirectUri.isPresent() && !isAuthorizedRedirectUri(redirectUri.get())) {
            throw new IllegalArgumentException("Sorry! We've got an Unauthorized Redirect URI and can't proceed with the authentication");
        }

        String targetUrl = redirectUri.orElse(getDefaultTargetUrl());

        OAuth2AuthenticationToken authToken = (OAuth2AuthenticationToken) authentication;
        Provider provider = Provider.valueOf(authToken.getAuthorizedClientRegistrationId().toUpperCase());

        OidcUser user = ((OidcUser) authentication.getPrincipal());
        OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, user.getAttributes());
        Collection<? extends GrantedAuthority> authorities = ((OidcUser) authentication.getPrincipal()).getAuthorities();

        Role role = hasAuthority(authorities, Role.ADMIN.getCode()) ? Role.ADMIN : Role.USER;

        Date now = new Date();

        JwtAuthToken accessToken = jwtAuthTokenProvider.createAuthToken(
                userInfo.getId(),
                role.getCode(),
                new Date(now.getTime() + appProperties.getAuth().getTokenExpiry())
        );

        // refresh 토큰 설정
        long refreshTokenExpiry = appProperties.getAuth().getRefreshTokenExpiry();

        JwtAuthToken refreshToken = jwtAuthTokenProvider.createAuthToken(
                appProperties.getAuth().getTokenSecret(),
                new Date(now.getTime() + refreshTokenExpiry)
        );

        // DB 저장
        userRefreshTokenService.saveOrUpdate(userInfo.getId(), refreshToken.getToken());
        System.out.println(accessToken.getToken());
        return UriComponentsBuilder.fromUriString(targetUrl + SUCCESS_COMMAND)
                .queryParam("access-token", accessToken.getToken())
                .queryParam("refresh-token", refreshToken.getToken())
                .build().toUriString();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, HttpServletResponse response) {
        super.clearAuthenticationAttributes(request);
        authorizationRequestRepository.removeAuthorizationRequestCookies(request, response);
    }

    private boolean hasAuthority(Collection<? extends GrantedAuthority> authorities, String authority) {
        if (authorities == null) {
            return false;
        }

        for (GrantedAuthority grantedAuthority : authorities) {
            if (authority.equals(grantedAuthority.getAuthority())) {
                return true;
            }
        }
        return false;
    }

    private boolean isAuthorizedRedirectUri(String uri) {
        URI clientRedirectUri = URI.create(uri);

        return appProperties.getOauth2().getAuthorizedRedirectUris()
                .stream()
                .anyMatch(authorizedRedirectUri -> {
                    // Only validate host and port. Let the clients use different paths if they want to
                    URI authorizedURI = URI.create(authorizedRedirectUri);
                    // app의 경우 host가 없다. -> authorizedURI.getHost() = null로 나온다.
//                    if (authorizedURI.getHost().equalsIgnoreCase(clientRedirectUri.getHost())
//                            && authorizedURI.getPort() == clientRedirectUri.getPort()) {
//                        return true;
//                    }
                    if (authorizedURI.getHost() != null) {
                        if (authorizedURI.getHost().equalsIgnoreCase(clientRedirectUri.getHost())
                                && authorizedURI.getPort() == clientRedirectUri.getPort()) {
                            return true;
                        }
                    } else { // 앱인 경우 (앱 uri는 호스트와 포트를 검사할 수 없음)
                        if (authorizedURI.equals(clientRedirectUri)) {
                            return true;
                        }
                    }
                    return false;
                });
    }
}

