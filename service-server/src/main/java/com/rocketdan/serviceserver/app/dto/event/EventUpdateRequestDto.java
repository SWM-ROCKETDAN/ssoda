package com.rocketdan.serviceserver.app.dto.event;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventUpdateRequestDto {
    private String title;
    private Integer status;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date finishDate;

    private List<MultipartFile> images;
    private List<MultipartFile> newImages;
    private List<String> deleteImagePaths;

    public EventUpdateRequestDto(String title, Integer status, Date startDate, Date finishDate, List<MultipartFile> images, List<MultipartFile> newImages, List<String> deleteImagePaths) {
        this.title = title;
        this.status = status;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
        this.newImages = newImages;
        this.deleteImagePaths = deleteImagePaths;
    }
}
