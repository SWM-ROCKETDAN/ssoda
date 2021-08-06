package com.rocketdan.serviceserver.Exception.analysis;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class AnalysisServerErrorException extends RuntimeException{

    public AnalysisServerErrorException(){
        super(ErrorCode.ANALYSIS_SERVER_ERROR.getMessage());
    }

    private AnalysisServerErrorException(String msg){
        super(msg);
    }
}
