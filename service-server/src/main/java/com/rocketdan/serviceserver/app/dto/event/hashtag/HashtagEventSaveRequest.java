package com.rocketdan.serviceserver.app.dto.event.hashtag;

import com.rocketdan.serviceserver.app.dto.event.EventSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import lombok.Builder;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

public class HashtagEventSaveRequest extends EventSaveRequestDto {
    private List<String> hashtags;
    private List<Boolean> requirements;
    private Integer template;

    @Builder
    public HashtagEventSaveRequest(String title, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date startDate, @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date finishDate, List<MultipartFile> images,
                                   List<String> hashtags, List<Boolean> requirements, Integer template) {
        super(title, startDate, finishDate, images);
        this.hashtags = hashtags;
        this.requirements = requirements;
        this.template = template;
    }

    // imgPaths는 나중에 주입받아야 하므로
    public Hashtag toEntity(List<String> imgPaths) {
        return Hashtag.builder()
                .title(super.getTitle())
                .startDate(super.getStartDate())
                .finishDate(super.getFinishDate())
                .images(imgPaths)
                .hashtags(hashtags)
                .requirements(requirements)
                .template(template)
                .build();
    }
}
