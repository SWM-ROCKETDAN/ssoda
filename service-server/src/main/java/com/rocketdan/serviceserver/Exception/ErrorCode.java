package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // 로그인, 권한
    AUTHENTICATION_FAILED(401, "AUTH001", " AUTHENTICATION_FAILED."), // 인증 실패
    LOGIN_FAILED(401, "AUTH002", " LOGIN_FAILED."), // login 실패
    INVALID_JWT_TOKEN(401, "AUTH003", "INVALID_JWT_TOKEN."), // 토큰 invalid
    INVALID_ACCESS_TOKEN(401, "AUTH004", "INVALID_ACCESS_TOKEN."), // access 토큰 invalid
    INVALID_REFRESH_TOKEN(401, "AUTH005", "INVALID_REFRESH_TOKEN."), // refresh 토큰 invalid
    NO_EXPIRED_TOKEN_YET(403, "AUTH006", "NO_EXPIRED_TOKEN_YET."), // 아직 만료되지 않은 토큰으로 refresh 요청
    NO_AUTHORITY(403, "AUTH007", "NO_AUTHORITY_TO_RESOURCE."), // 불법적인 리소스 접근
    // file 처리
    FILE_UPLOAD_FAILED(500, "FILE001", "FILE_UPLOAD_FAILED."), // 파일 업로드 실패
    FILE_CONVERT_FAILED(500, "FILE002", "FILE_CONVERT_FAILED."), // 파일 변환 실패
    // 이벤트 참여
    JOIN_EVENT_FAILED(406, "JOIN_EVENT001", "JOIN_EVENT_FAILED."),
    JOIN_DIFFERENT_EVENT(406, "JOIN_EVENT002", "JOIN_DIFFERENT_EVENT."), // 이전에 참여한 이벤트와 다른 이벤트
    JOIN_INVALID_EVENT(406, "JOIN_EVENT003", "JOIN_INVALID_EVENT."), // 유효하지 않은 이벤트에 참여(진행중이 아닌)
    // Analysis server
    ANALYSIS_SERVER_ERROR(500, "ANALYSIS001", "ANALYSIS_SERVER_ERROR."); // 분석 서버 에러(scraping 불가 등)


    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
