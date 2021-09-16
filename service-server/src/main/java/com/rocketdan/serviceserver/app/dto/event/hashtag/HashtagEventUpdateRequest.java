package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Getter
public class HashtagEventUpdateRequest extends EventUpdateRequestDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    @Builder
    public HashtagEventUpdateRequest(String title, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") LocalDateTime startDate, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") LocalDateTime finishDate, List<MultipartFile> newImages, List<String> deleteImagePaths,
                                     List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, startDate, finishDate, newImages, deleteImagePaths);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }
}
