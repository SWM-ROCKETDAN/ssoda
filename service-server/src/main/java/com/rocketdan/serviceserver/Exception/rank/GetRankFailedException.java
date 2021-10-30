package com.rocketdan.serviceserver.Exception.rank;


import com.rocketdan.serviceserver.Exception.ErrorCode;
import com.rocketdan.serviceserver.core.CommonResponse;

public class GetRankFailedException extends RuntimeException{

    public GetRankFailedException(){
        super(ErrorCode.GET_RANK_FAILED.getMessage());
    }

    private GetRankFailedException(String msg){
        super(msg);
    }

    public GetRankFailedException(CommonResponse commonResponse){
        super(commonResponse.getMessage());
    }
}
