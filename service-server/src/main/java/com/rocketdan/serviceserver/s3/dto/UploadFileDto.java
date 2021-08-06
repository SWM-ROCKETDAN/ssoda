package com.rocketdan.serviceserver.s3.dto;

import lombok.Getter;

@Getter
public class UploadFileDto {
    // 원본파일 명
    private String originalFileName;
    // 업로드 파일경로
    private String uploadFilePath;

    private UploadFileDto(String originalFileName, String uploadFilePath) {
        this.originalFileName = originalFileName;
        this.uploadFilePath = uploadFilePath;
    }

    public static UploadFileDto create(String originalFileName, String uploadFilePath) {
        return new UploadFileDto(originalFileName, uploadFilePath);
    }
}
