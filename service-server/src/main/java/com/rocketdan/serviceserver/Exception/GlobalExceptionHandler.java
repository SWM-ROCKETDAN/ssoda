package com.rocketdan.serviceserver.Exception;

import com.rocketdan.serviceserver.Exception.file.FileConvertException;
import com.rocketdan.serviceserver.Exception.file.FileUploadException;
import com.rocketdan.serviceserver.core.CommonResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

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

    // file 처리

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
}
