package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // 로그인
    AUTHENTICATION_FAILED(401, "AUTH001", " AUTHENTICATION_FAILED."),
    LOGIN_FAILED(401, "AUTH002", " LOGIN_FAILED."),
    INVALID_JWT_TOKEN(401, "AUTH003", "INVALID_JWT_TOKEN."),
    // 이벤트 참여
    DUPLICATE_POST_URL(403, "EVENT_JOIN001", "DUPLICATE_POST_URL."),
    JOIN_EVENT_FAILED(403, "EVENT_JOIN002", "JOIN_EVENT_FAILED.");

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
