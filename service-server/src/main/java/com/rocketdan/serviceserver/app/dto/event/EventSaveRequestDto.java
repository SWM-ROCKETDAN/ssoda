package com.rocketdan.serviceserver.app.dto.event;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class EventSaveRequestDto {
    private String rewardPolicy;
    private String title;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime finishDate;
    private List<MultipartFile> images;

    public EventSaveRequestDto(String rewardPolicy, String title, LocalDateTime startDate, LocalDateTime finishDate, List<MultipartFile> images) {
        this.rewardPolicy = rewardPolicy;
        this.title = title;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
    }
}
