package com.rocketdan.serviceserver.Exception;

public class DuplicateUrlException extends RuntimeException {

    public DuplicateUrlException(){
        super(ErrorCode.DUPLICATE_POST_URL.getMessage());
    }

    private DuplicateUrlException(String msg){
        super(msg);
    }
}
