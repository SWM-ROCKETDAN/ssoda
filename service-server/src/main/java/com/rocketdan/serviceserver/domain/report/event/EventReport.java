package com.rocketdan.serviceserver.domain.report.event;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rocketdan.serviceserver.domain.event.Event;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
@SQLDelete(sql = "UPDATE event_report SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
public class EventReport {
    @Id
    @JsonIgnore
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Event event;

    // 노출 수
    private Integer exposureCount;

    // 참여 수
    private Integer participateCount;

    // 공개 게시글 수
    private Integer publicPostCount;

    // 비공개 게시글 수
    private Integer privatePostCount;

    // 삭제 게시글 수
    private Integer deletedPostCount;

    // 좋아요 수
    private Integer likeCount;

    // 댓글 수
    private Integer commentCount;

    // 지출
    private Integer expenditureCount;

    // 이벤트의 상태
    private Integer eventStatus;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;
}
