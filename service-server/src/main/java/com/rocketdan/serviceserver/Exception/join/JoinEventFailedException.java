package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class JoinEventFailedException extends RuntimeException{

    public JoinEventFailedException(){
        super(ErrorCode.JOIN_EVENT_FAILED.getMessage());
    }

    private JoinEventFailedException(String msg){
        super(msg);
    }
}
