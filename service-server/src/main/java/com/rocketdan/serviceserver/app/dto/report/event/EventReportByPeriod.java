package com.rocketdan.serviceserver.app.dto.report.event;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class EventReportByPeriod {
    // 노출 수
    private List<Integer> exposure_count;
    // 참여 수
    private List<Integer> participate_count;
    // 공개 게시글 수
    private List<Integer> public_post_count;
    // 비공개 게시글 수
    private List<Integer> private_post_count;
    // 삭제 게시글 수
    private List<Integer> deleted_post_count;
    // 좋아요 수
    private List<Integer> like_count;
    // 댓글 수
    private List<Integer> comment_count;
    // 지출
    private List<Integer> expenditure_count;
    // 레벨 당 지출
    private List<Integer> level_expenditure;
}
