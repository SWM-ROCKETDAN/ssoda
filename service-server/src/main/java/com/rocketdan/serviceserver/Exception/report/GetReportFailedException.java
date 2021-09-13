package com.rocketdan.serviceserver.Exception.report;

import com.rocketdan.serviceserver.Exception.ErrorCode;
import com.rocketdan.serviceserver.core.CommonResponse;

public class GetReportFailedException extends RuntimeException{

    public GetReportFailedException(){
        super(ErrorCode.GET_REPORT_FAILED.getMessage());
    }

    private GetReportFailedException(String msg){
        super(msg);
    }

    public GetReportFailedException(CommonResponse commonResponse){
        super(commonResponse.getMessage());
    }
}
