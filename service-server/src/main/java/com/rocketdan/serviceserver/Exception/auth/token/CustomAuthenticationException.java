package com.rocketdan.serviceserver.Exception.auth.token;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class CustomAuthenticationException extends RuntimeException {

    public CustomAuthenticationException(){
        super(ErrorCode.INVALID_JWT_TOKEN.getMessage());
    }

    public CustomAuthenticationException(Exception ex){
        super(ex);
    }
}

