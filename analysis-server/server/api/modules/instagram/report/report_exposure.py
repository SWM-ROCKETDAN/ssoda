from server.secret.config import InstagramReport


def get_exposure_count(follow_count: int):
    return int(follow_count * InstagramReport.REACH)
