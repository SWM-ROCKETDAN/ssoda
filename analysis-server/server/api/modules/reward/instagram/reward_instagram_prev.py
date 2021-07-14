# 이전 데이터 점수 계산 - 게시물 유지 기간, ER 지수
def calculate_prev(post_upload, post_transition):
    # 게시물 유지 기간 계산하기 -> event_post db에서 upload_date, transition_date 가져오기 -> 차이 계산

    # ER 지수 평균치 계산하기 -> event_user_id로 모든 게시물 검색 -> 좋아요 수 + 댓글 수 / 팔로워 수 평균치 계산

    # 만약 첫 사용자라면 평균 점수 산출
    pass
