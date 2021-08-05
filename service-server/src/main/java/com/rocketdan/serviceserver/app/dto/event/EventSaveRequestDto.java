package com.rocketdan.serviceserver.app.dto.event;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class EventSaveRequestDto {
    private String title;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date finishDate;
    private List<MultipartFile> images;

    public EventSaveRequestDto(String title, Date startDate, Date finishDate, List<MultipartFile> images) {
        this.title = title;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
    }
}
