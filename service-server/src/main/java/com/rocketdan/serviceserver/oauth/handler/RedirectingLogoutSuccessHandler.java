package com.rocketdan.serviceserver.oauth.handler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class RedirectingLogoutSuccessHandler implements LogoutSuccessHandler {
    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {
        // redirect하지 않음. front에 200 OK만 리턴
        // refresh token 삭제
        log.info("logout");
    }
}
