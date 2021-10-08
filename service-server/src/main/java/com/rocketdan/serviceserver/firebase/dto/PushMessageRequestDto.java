package com.rocketdan.serviceserver.firebase.dto;

import lombok.Getter;

import java.util.Map;

@Getter
public class PushMessageRequestDto {
    private String title;
    private String body;
    private String image;
    private Map<String, String> data;
}
