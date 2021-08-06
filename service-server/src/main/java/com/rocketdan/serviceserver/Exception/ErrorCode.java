package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // 로그인
    AUTHENTICATION_FAILED(401, "AUTH001", " AUTHENTICATION_FAILED."),
    LOGIN_FAILED(401, "AUTH002", " LOGIN_FAILED."),
    INVALID_JWT_TOKEN(401, "AUTH003", "INVALID_JWT_TOKEN."),
    // file 처리
    FILE_UPLOAD_FAILED(500, "FILE001", "FILE_UPLOAD_FAILED."),
    FILE_CONVERT_FAILED(500, "FILE002", "FILE_CONVERT_FAILED."),
    // 이벤트 참여
    DUPLICATE_POST_URL(403, "EVENT_JOIN001", "DUPLICATE_POST_URL."),
    JOIN_EVENT_FAILED(403, "EVENT_JOIN002", "JOIN_EVENT_FAILED."),

    ANALYSIS_SERVER_ERROR(500, "ANALYSIS001", "ANALYSIS_SERVER_ERROR.");

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
