package com.rocketdan.serviceserver.Exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // 로그인, 권한
    AUTHENTICATION_FAILED(401, "AUTH001", "Authentication failed."), // 인증 실패
    LOGIN_FAILED(401, "AUTH002", "Login failed."), // login 실패
    INVALID_JWT_TOKEN(401, "AUTH003", "Token is not valid."), // 토큰 invalid
    INVALID_ACCESS_TOKEN(401, "AUTH004", "Access token is not valid."), // access 토큰 invalid
    INVALID_REFRESH_TOKEN(401, "AUTH005", "Refresh token is not valid."), // refresh 토큰 invalid
    NO_EXPIRED_TOKEN_YET(403, "AUTH006", "The token has not expired yet.\n"), // 아직 만료되지 않은 토큰으로 refresh 요청
    NO_AUTHORITY(403, "AUTH007", "It's an illegal resource access."), // 불법적인 리소스 접근
    // file 처리
    FILE_UPLOAD_FAILED(500, "FILE001", "File upload failed."), // 파일 업로드 실패
    FILE_CONVERT_FAILED(500, "FILE002", "File convert failed."), // 파일 변환 실패
    // 이벤트 참여
    JOIN_EVENT_FAILED(406, "JOIN_EVENT001", "Failed to participate in the event."),
    JOIN_DIFFERENT_EVENT(406, "JOIN_EVENT002", "It's different from the previous event."), // 이전에 참여한 이벤트와 다른 이벤트
    JOIN_INVALID_EVENT(406, "JOIN_EVENT003", "Event is not valid."), // 유효하지 않은 이벤트에 참여(진행중이 아닌)
    NO_REWARD_FOR_EVENT(500, "JOIN_EVENT004", "There is no reward for the event."), // 이벤트에 등록된 리워드가 없음
    // Analysis server
    ANALYSIS_SERVER_ERROR(500, "ANALYSIS001", "Analysis server error."), // 분석 서버 에러(scraping 불가 등)
    // 리포트
    GET_REPORT_FAILED(406, "REPORT001", "Failed to get report."), // report get 실패
    // Request
    INVALID_REQUEST_BODY(403, "REQUEST001", "Request body is invalid"); // request 내용이 invalid 한 경우

    private final String code;
    private final String message;
    private int status;

    ErrorCode(final int status, final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
}
