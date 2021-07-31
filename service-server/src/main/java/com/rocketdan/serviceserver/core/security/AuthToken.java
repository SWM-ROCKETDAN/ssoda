package com.rocketdan.serviceserver.core.security;

public interface AuthToken<T> {
    boolean validate();
    T getData();
}
