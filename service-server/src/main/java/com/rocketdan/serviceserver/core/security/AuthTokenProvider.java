package com.rocketdan.serviceserver.core.security;

import java.util.Date;

public interface AuthTokenProvider<T> {
    T createAuthToken(String email, String role, Date expiredDate);
    T convertAuthToken(String token);
}