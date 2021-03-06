package com.rocketdan.serviceserver.app.dto.rank;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Optional;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class EventRankResponseDto {
    // 이벤트 id
    private Long eventId;
    // 가게 id
    private Long storeId;
    // 이벤트를 진행하는 가게 명
    private String storeName;
    // 이벤트를 진행하는 가게 로고 이미지 path
    private String storeLogoImagePath;
    // 이벤트 제목
    private String eventTitle;
    // 이벤트 대표 이미지 path (0번째 index)
    private String eventImagePath;
    // 객단가
    private Double guestPrice;
    // 참여 수
    private Integer participateCount;
    // 반응 수
    private Integer reactCount;

    public EventRankResponseDto(Event event, Store store, EventRankReceiveDto eventRankReceiveDto) {
        this.eventId = event.getId();
        this.storeId = store.getId();
        this.storeName = store.getName();
        this.storeLogoImagePath = store.getLogoImagePath();
        this.eventTitle = event.getTitle();
        Optional.ofNullable(event.getImagePaths()).ifPresent(none -> this.eventImagePath = event.getImagePaths().get(0));
        this.guestPrice = eventRankReceiveDto.getGuest_price();
        this.participateCount = eventRankReceiveDto.getParticipate_count();
        this.reactCount = eventRankReceiveDto.getReact_count();
    }
}
