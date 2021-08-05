package com.rocketdan.serviceserver.app.dto.event;

import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class EventSaveRequestDto {
    private String title;
    private Date startDate;
    private Date finishDate;
    private List<MultipartFile> images;

    public EventSaveRequestDto(String title, Date startDate, Date finishDate, List<MultipartFile> images) {
        this.title = title;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
    }
}
