package com.rocketdan.serviceserver.Exception;

public class JoinEventFailedException extends RuntimeException{

    public JoinEventFailedException(){
        super(ErrorCode.DUPLICATE_POST_URL.getMessage());
    }

    private JoinEventFailedException(String msg){
        super(msg);
    }
}
