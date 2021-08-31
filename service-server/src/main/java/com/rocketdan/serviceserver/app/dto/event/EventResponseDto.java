package com.rocketdan.serviceserver.app.dto.event;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Getter
@NoArgsConstructor
public class EventResponseDto {
    private Long id;
    private String title;
    private Integer status;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    private Date startDate;
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    private Date finishDate;
    private List<String> images;
    private String type;
    private Long store_id;

    public EventResponseDto(Event entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.status = entity.getStatus();
        this.startDate = entity.getStartDate();
        this.finishDate = entity.getFinishDate();
        this.images = List.copyOf(entity.getImagePaths());
        this.type = entity.getType();
        this.store_id = entity.getStore().getId();
    }
}
