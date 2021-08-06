package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class DuplicateUrlException extends RuntimeException {

    public DuplicateUrlException(){
        super(ErrorCode.DUPLICATE_POST_URL.getMessage());
    }

    private DuplicateUrlException(String msg){
        super(msg);
    }
}
