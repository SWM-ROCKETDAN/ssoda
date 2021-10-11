package com.rocketdan.serviceserver.firebase.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
public class PushMessageRequestDto {
    private String title;
    private String body;
    private String image;
    private Map<String, String> data;
}
