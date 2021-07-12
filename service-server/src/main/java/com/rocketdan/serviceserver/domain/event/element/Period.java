package com.rocketdan.serviceserver.domain.event.element;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Date;

@Getter
@AllArgsConstructor
public class Period {
    // 이벤트 영구 유지 여부
    private Boolean isPermanent;

    // 이벤트 시작 시간
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    private Date startDate;

    // 이벤트 끝 시간
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    private Date finishDate;
}