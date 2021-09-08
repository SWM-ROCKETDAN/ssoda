package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;
import com.rocketdan.serviceserver.core.CommonResponse;

public class JoinEventFailedException extends RuntimeException{

    public JoinEventFailedException(){
        super(ErrorCode.JOIN_EVENT_FAILED.getMessage());
    }

    public JoinEventFailedException(String msg){
        super(msg);
    }

    public JoinEventFailedException(CommonResponse commonResponse){
        super(commonResponse.getMessage());
    }
}
