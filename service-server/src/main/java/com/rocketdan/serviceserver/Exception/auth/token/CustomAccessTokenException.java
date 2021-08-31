package com.rocketdan.serviceserver.Exception.auth.token;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class CustomAccessTokenException extends RuntimeException {

    public CustomAccessTokenException(){
        super(ErrorCode.INVALID_ACCESS_TOKEN.getMessage());
    }

    public CustomAccessTokenException(Exception ex){
        super(ex);
    }
}
