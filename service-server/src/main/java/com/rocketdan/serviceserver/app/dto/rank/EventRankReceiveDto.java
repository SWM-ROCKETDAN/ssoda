package com.rocketdan.serviceserver.app.dto.rank;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class EventRankReceiveDto {
    // 이벤트 아이디
    private Long event_id;
    // 객단가
    private Double guest_price;
    // 참여수
    private Integer participate_count;
    // 반응 수 (좋아요 수 + 댓글 수)
    private Integer react_count;

    @Builder
    public EventRankReceiveDto(Long event_id, Double guest_price, Integer participate_count, Integer react_count) {
        this.event_id = event_id;
        this.guest_price = guest_price;
        this.participate_count = participate_count;
        this.react_count = react_count;
    }
}
