package com.rocketdan.serviceserver.Exception.auth.token;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class NoExpiredTokenYetException extends RuntimeException{

    public NoExpiredTokenYetException(){
        super(ErrorCode.NO_EXPIRED_TOKEN_YET.getMessage());
    }

    public NoExpiredTokenYetException(Exception ex){
        super(ex);
    }
}

