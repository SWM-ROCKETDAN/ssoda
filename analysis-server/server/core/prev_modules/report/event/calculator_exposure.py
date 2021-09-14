from server.core.modules.static.common import Type
from server.core.modules.static.report import InstagramReport

K = 1000


def calculate_exposure_count(follow_count, sns_type):
    if follow_count is None:
        follow_count = 0
    if sns_type is None:
        sns_type = Type.INSTAGRAM

    exposure_count = 0
    if sns_type == Type.INSTAGRAM:
        if 0 <= follow_count < 10 * K:
            exposure_count = follow_count * InstagramReport.REACH_BY_FOLLOW_FROM_0K_TO_10K
        elif 10 * K <= follow_count < 50 * K:
            exposure_count = follow_count * InstagramReport.REACH_BY_FOLLOW_FROM_10K_TO_50K
        elif 50 * K <= follow_count < 200 * K:
            exposure_count = follow_count * InstagramReport.REACH_BY_FOLLOW_FROM_50K_TO_200K
        else:
            exposure_count = follow_count * InstagramReport.REACH_BY_FOLLOW_FROM_200K_TO_INFINITE

    if sns_type == Type.FACEBOOK:
        pass

    return int(exposure_count)
