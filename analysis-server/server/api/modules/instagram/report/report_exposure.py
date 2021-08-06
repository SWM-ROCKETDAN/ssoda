from server.secret.config import InstagramReport


def get_exposure(follow_count: int):
    return follow_count * InstagramReport.REACH
