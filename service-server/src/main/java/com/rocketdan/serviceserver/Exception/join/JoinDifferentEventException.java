package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class JoinDifferentEventException extends RuntimeException{

    public JoinDifferentEventException(){
        super(ErrorCode.JOIN_DIFFERENT_EVENT.getMessage());
    }

    private JoinDifferentEventException(String msg){
        super(msg);
    }
}