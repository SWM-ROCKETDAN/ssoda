package com.rocketdan.serviceserver.config.auth;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import org.springframework.stereotype.Component;

@Component
public class UserIdValidCheck {
    public void userIdValidCheck(String userId, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        if(!principal.getUsername().equals(userId)) {
            throw new NoAuthorityToResourceException();
        }
    }
}
