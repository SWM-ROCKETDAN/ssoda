from datetime import datetime
from .report_assistant_day import get_day_list
from .report_assistant_parser import parse_to_report_dict
from .report_assistant_parser import parse_to_dict
from .report_exposure import get_exposure_count
from .report_participate import get_participate_count
from .report_post import get_post_count
from .report_post import get_private_post_count
from .report_post import get_deleted_post_count
from .report_engagement import get_like_count
from .report_engagement import get_comment_count
from .report_expenditure import get_expenditure_count


# 리포트 딕셔너리 얻기
def get_report_dict(join_list: list, event):
    # 리포트 딕셔너리 생성
    report_dict = parse_to_dict(get_day_list(event))

    # 게시물 한 개씩 확인 후 리포트 딕셔너리 업데이트
    for join in join_list:
        upload_date = datetime.strptime(join['upload_date'], '%Y-%m-%dT%H:%M:%S').date()
        if upload_date in report_dict:
            report_dict[upload_date]['exposure_count'] += get_exposure_count(join['join_user']['follow_count'])
            report_dict[upload_date]['participate_count'] += get_participate_count()
            report_dict[upload_date]['post_count'] += get_post_count()
            report_dict[upload_date]['private_post_count'] += get_private_post_count(join['status'])
            report_dict[upload_date]['deleted_post_count'] += get_deleted_post_count(join['status'])
            report_dict[upload_date]['like_count'] += get_like_count(join['like_count'])
            report_dict[upload_date]['comment_count'] += get_comment_count(join['comment_count'])
            report_dict[upload_date]['expenditure_count'] += get_expenditure_count(join['reward']['price'] if join['reward'] else 0)

    # 리포트 딕셔너리 파싱
    report_dict = parse_to_report_dict(report_dict)

    return report_dict
