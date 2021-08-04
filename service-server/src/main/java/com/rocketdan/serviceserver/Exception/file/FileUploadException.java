package com.rocketdan.serviceserver.Exception.file;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class FileUploadException extends RuntimeException {

    public FileUploadException(){
        super(ErrorCode.FILE_UPLOAD_FAILED.getMessage());
    }

    private FileUploadException(String msg){
        super(msg);
    }
}
