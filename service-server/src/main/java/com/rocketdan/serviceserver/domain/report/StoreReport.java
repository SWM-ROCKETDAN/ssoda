package com.rocketdan.serviceserver.domain.report;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StoreReport {
    // 노출 수
    private Integer exposure_count;
    // 참여 수
    private Integer participate_count;
    // 공개 게시글 수
    private Integer public_post_count;
    // 비공개 게시글 수
    private Integer private_post_count;
    // 삭제 게시글 수
    private Integer deleted_post_count;
    // 좋아요 수
    private Integer like_count;
    // 댓글 수
    private Integer comment_count;
    // 지출 수
    private Integer expenditure_count;
}
