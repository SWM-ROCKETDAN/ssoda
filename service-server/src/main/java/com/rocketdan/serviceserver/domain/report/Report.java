package com.rocketdan.serviceserver.domain.report;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class Report<T> {
    // 노출 수
    private T exposure_count;
    // 참여 수
    private T participate_count;
    // 공개 게시글 수
    private T public_post_count;
    // 비공개 게시글 수
    private T private_post_count;
    // 삭제 게시글 수
    private T deleted_post_count;
    // 좋아요 수
    private T like_count;
    // 댓글 수
    private T comment_count;
    // 지출 수
    private T expenditure_count;
}
