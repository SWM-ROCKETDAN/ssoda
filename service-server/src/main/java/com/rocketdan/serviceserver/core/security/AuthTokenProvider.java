package com.rocketdan.serviceserver.core.security;

import java.util.Date;

public interface AuthTokenProvider<T> {
    T createAuthToken(String id, String role, Date expiredDate);
    T createAuthToken(String id, Date expiredDate);
    T convertAuthToken(String token);
}