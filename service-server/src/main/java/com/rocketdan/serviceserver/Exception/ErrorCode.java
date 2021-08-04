package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {

    AUTHENTICATION_FAILED(401, "AUTH001", " AUTHENTICATION_FAILED."),
    LOGIN_FAILED(401, "AUTH002", " LOGIN_FAILED."),
    INVALID_JWT_TOKEN(401, "AUTH003", "INVALID_JWT_TOKEN."),

    FILE_UPLOAD_FAILED(500, "FILE001", "FILE_UPLOAD_FAILED."),
    FILE_CONVERT_FAILED(500, "FILE002", "FILE_CONVERT_FAILED.");

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
