package com.rocketdan.serviceserver.Exception.resource;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class InvalidRequestBodyException extends RuntimeException {

    public InvalidRequestBodyException(){
        super(ErrorCode.INVALID_REQUEST_BODY.getMessage());
    }

    public InvalidRequestBodyException(String msg){
        super(msg);
    }
}
