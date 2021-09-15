package com.rocketdan.serviceserver.Exception;

import com.rocketdan.serviceserver.Exception.auth.token.CustomAccessTokenException;
import com.rocketdan.serviceserver.Exception.auth.token.CustomRefreshTokenException;
import com.rocketdan.serviceserver.Exception.auth.token.NoExpiredTokenYetException;
import com.rocketdan.serviceserver.Exception.file.FileConvertException;
import com.rocketdan.serviceserver.Exception.file.FileUploadException;
import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinDifferentEventException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.Exception.auth.token.CustomAuthenticationException;
import com.rocketdan.serviceserver.Exception.auth.CustomJwtRuntimeException;
import com.rocketdan.serviceserver.Exception.auth.LoginFailedException;
import com.rocketdan.serviceserver.Exception.join.JoinInvalidEventException;
import com.rocketdan.serviceserver.Exception.join.NoRewardForEventException;
import com.rocketdan.serviceserver.Exception.resource.InvalidRequestBodyException;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.core.CommonResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    /*
    로그인, 리소스 권한
     */

    @ExceptionHandler(CustomAuthenticationException.class)
    protected ResponseEntity<CommonResponse> handleCustomAuthenticationException(CustomAuthenticationException e) {

        log.info("handleCustomAuthenticationException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.AUTHENTICATION_FAILED.getCode())
                .message(e.getMessage())
                .status(ErrorCode.AUTHENTICATION_FAILED.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(LoginFailedException.class)
    protected ResponseEntity<CommonResponse> handleLoginFailedException(LoginFailedException e) {

        log.info("handleLoginFailedException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.LOGIN_FAILED.getCode())
                .message(e.getMessage())
                .status(ErrorCode.LOGIN_FAILED.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(CustomJwtRuntimeException.class)
    protected ResponseEntity<CommonResponse> handleJwtException(CustomJwtRuntimeException e) {

        log.info("handleJwtException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.INVALID_JWT_TOKEN.getCode())
                .message(ErrorCode.INVALID_JWT_TOKEN.getMessage())
                .status(ErrorCode.INVALID_JWT_TOKEN.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(CustomAccessTokenException.class)
    protected ResponseEntity<CommonResponse> handleCustomAccessTokenException(CustomAccessTokenException e) {

        log.info("handleCustomAccessTokenException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.INVALID_ACCESS_TOKEN.getCode())
                .message(ErrorCode.INVALID_ACCESS_TOKEN.getMessage())
                .status(ErrorCode.INVALID_ACCESS_TOKEN.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(CustomRefreshTokenException.class)
    protected ResponseEntity<CommonResponse> handleCustomRefreshTokenException(CustomRefreshTokenException e) {

        log.info("handleCustomRefreshTokenException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.INVALID_REFRESH_TOKEN.getCode())
                .message(ErrorCode.INVALID_REFRESH_TOKEN.getMessage())
                .status(ErrorCode.INVALID_REFRESH_TOKEN.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(NoExpiredTokenYetException.class)
    protected ResponseEntity<CommonResponse> handleNoExpiredTokenYetException(NoExpiredTokenYetException e) {

        log.info("handleNoExpiredTokenYetException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.NO_EXPIRED_TOKEN_YET.getCode())
                .message(ErrorCode.NO_EXPIRED_TOKEN_YET.getMessage())
                .status(ErrorCode.NO_EXPIRED_TOKEN_YET.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(NoAuthorityToResourceException.class)
    protected ResponseEntity<CommonResponse> handleNoAuthorityToResourceException(NoAuthorityToResourceException e) {

        log.info("handleNoAuthorityToResourceException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.NO_AUTHORITY.getCode())
                .message(ErrorCode.NO_AUTHORITY.getMessage())
                .status(ErrorCode.NO_AUTHORITY.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

    /*
    file 처리
     */

    @ExceptionHandler(FileUploadException.class)
    protected ResponseEntity<CommonResponse> handleFileUploadException(FileUploadException e) {

        log.info("handleFileUploadException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.FILE_UPLOAD_FAILED.getCode())
                .message(ErrorCode.FILE_UPLOAD_FAILED.getMessage())
                .status(ErrorCode.FILE_UPLOAD_FAILED.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(FileConvertException.class)
    protected ResponseEntity<CommonResponse> handleFileConvertException(FileConvertException e) {

        log.info("handleFileConvertException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.FILE_CONVERT_FAILED.getCode())
                .message(ErrorCode.FILE_CONVERT_FAILED.getMessage())
                .status(ErrorCode.FILE_CONVERT_FAILED.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /*
    event 참여
     */

    @ExceptionHandler(JoinEventFailedException.class)
    protected ResponseEntity<CommonResponse> handleJoinEventFailedException(JoinEventFailedException e) {

        log.info("handleJoinEventFailedException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.JOIN_EVENT_FAILED.getCode())
                .message(e.getMessage())
                .status(ErrorCode.JOIN_EVENT_FAILED.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.NOT_ACCEPTABLE);
    }

    @ExceptionHandler(JoinDifferentEventException.class)
    protected ResponseEntity<CommonResponse> handleJoinDifferentEventException(JoinDifferentEventException e) {

        log.info("handleJoinDifferentEventException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.JOIN_DIFFERENT_EVENT.getCode())
                .message(ErrorCode.JOIN_DIFFERENT_EVENT.getMessage())
                .status(ErrorCode.JOIN_DIFFERENT_EVENT.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.NOT_ACCEPTABLE);
    }

    @ExceptionHandler(JoinInvalidEventException.class)
    protected ResponseEntity<CommonResponse> handleJoinInvalidEventException(JoinInvalidEventException e) {

        log.info("handleJoinInvalidEventException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.JOIN_INVALID_EVENT.getCode())
                .message(ErrorCode.JOIN_INVALID_EVENT.getMessage())
                .status(ErrorCode.JOIN_INVALID_EVENT.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.NOT_ACCEPTABLE);
    }

    @ExceptionHandler(NoRewardForEventException.class)
    protected ResponseEntity<CommonResponse> handleNoRewardForEventException(NoRewardForEventException e) {

        log.info("handleNoRewardForEventException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.NO_REWARD_FOR_EVENT.getCode())
                .message(ErrorCode.NO_REWARD_FOR_EVENT.getMessage())
                .status(ErrorCode.NO_REWARD_FOR_EVENT.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.NOT_ACCEPTABLE);
    }

    /*
    Analysis server
     */

    @ExceptionHandler(AnalysisServerErrorException.class)
    protected ResponseEntity<CommonResponse> handleAnalysisServerErrorException(AnalysisServerErrorException e) {

        log.info("handleAnalysisServerErrorException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.ANALYSIS_SERVER_ERROR.getCode())
                .message(e.getMessage())
                .status(ErrorCode.ANALYSIS_SERVER_ERROR.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }


    /*
    Request
     */

    @ExceptionHandler(InvalidRequestBodyException.class)
    protected ResponseEntity<CommonResponse> handleInvalidRequestBodyException(InvalidRequestBodyException e) {

        log.info("handleInvalidRequestBodyException", e);

        CommonResponse response = CommonResponse.builder()
                .code(ErrorCode.INVALID_REQUEST_BODY.getCode())
                .message(e.getMessage())
                .status(ErrorCode.INVALID_REQUEST_BODY.getStatus())
                .build();

        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
