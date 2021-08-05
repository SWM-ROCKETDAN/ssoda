package com.rocketdan.serviceserver.app.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Setter
@Getter
@NoArgsConstructor
public class TestDto {
    private String name;
    private Integer age;
    private MultipartFile file;
    private List<MultipartFile> files;

    @Builder
    public TestDto(String name, Integer age, MultipartFile file, List<MultipartFile> files) {
        this.name = name;
        this.age = age;
        this.file = file;
        this.files = files;
    }
}
