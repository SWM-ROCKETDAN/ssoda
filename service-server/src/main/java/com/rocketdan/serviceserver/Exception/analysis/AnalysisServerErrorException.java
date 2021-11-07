package com.rocketdan.serviceserver.Exception.analysis;

import com.rocketdan.serviceserver.Exception.ErrorCode;
import com.rocketdan.serviceserver.core.CommonResponse;

public class AnalysisServerErrorException extends RuntimeException{

    public AnalysisServerErrorException(){
        super(ErrorCode.ANALYSIS_SERVER_ERROR.getMessage());
    }

    private AnalysisServerErrorException(String msg){
        super(msg);
    }

    public AnalysisServerErrorException(CommonResponse commonResponse){
        super(commonResponse.getMessage());
    }
}
