package com.rocketdan.serviceserver.Exception.resource;

import com.rocketdan.serviceserver.Exception.ErrorCode;

public class NoAuthorityToResourceException extends IllegalAccessException {
    public NoAuthorityToResourceException(){
        super(ErrorCode.NO_AUTHORITY.getMessage());
    }

    private NoAuthorityToResourceException(String msg){
        super(msg);
    }

}
