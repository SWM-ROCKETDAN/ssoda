package com.rocketdan.serviceserver.Exception.join;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class NoRewardForEventException extends RuntimeException{

    public NoRewardForEventException(){
        super(ErrorCode.NO_REWARD_FOR_EVENT.getMessage());
    }

    private NoRewardForEventException(String msg){
        super(msg);
    }
}
