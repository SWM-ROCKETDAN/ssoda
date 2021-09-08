package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class JoinInvalidEventException extends RuntimeException{

    public JoinInvalidEventException(){
        super(ErrorCode.JOIN_INVALID_EVENT.getMessage());
    }

    private JoinInvalidEventException(String msg){
        super(msg);
    }
}
