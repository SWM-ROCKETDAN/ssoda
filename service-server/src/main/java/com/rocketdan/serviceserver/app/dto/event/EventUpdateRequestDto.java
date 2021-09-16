package com.rocketdan.serviceserver.app.dto.event;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventUpdateRequestDto {
    private String title;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime finishDate;

    private List<MultipartFile> newImages;
    private List<String> deleteImagePaths;

    public EventUpdateRequestDto(String title, LocalDateTime startDate, LocalDateTime finishDate, List<MultipartFile> newImages, List<String> deleteImagePaths) {
        this.title = title;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.newImages = newImages;
        this.deleteImagePaths = deleteImagePaths;
    }
}
