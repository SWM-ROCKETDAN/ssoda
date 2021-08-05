package com.rocketdan.serviceserver.app.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@NoArgsConstructor
public class TestDto {
    private String name;
    private Integer age;
    private MultipartFile file;
    private List<MultipartFile> files;
}
