package com.rocketdan.serviceserver.Exception.file;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class FileConvertException extends RuntimeException {

    public FileConvertException(){
        super(ErrorCode.FILE_CONVERT_FAILED.getMessage());
    }

    private FileConvertException(String msg){
        super(msg);
    }
}
