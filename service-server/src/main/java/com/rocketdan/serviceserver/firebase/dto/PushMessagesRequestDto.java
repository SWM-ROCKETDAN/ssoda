package com.rocketdan.serviceserver.firebase.dto;

import lombok.Getter;

import java.util.List;
import java.util.Map;

@Getter
public class PushMessagesRequestDto {
    private List<Long> userIds;
    private String title;
    private String body;
    private String image;
    private Map<String, String> data;
}
