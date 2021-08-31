package com.rocketdan.serviceserver.Exception.auth.token;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class CustomRefreshTokenException extends RuntimeException{

    public CustomRefreshTokenException(){
        super(ErrorCode.INVALID_REFRESH_TOKEN.getMessage());
    }

    public CustomRefreshTokenException(Exception ex){
        super(ex);
    }
}
