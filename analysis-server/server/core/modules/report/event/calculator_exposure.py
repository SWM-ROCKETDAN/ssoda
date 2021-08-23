from server.core.modules.static.report import InstagramReport


def calculate_exposure_count(follow_count):
    if follow_count is None:
        return 0
    return int(follow_count * InstagramReport.REACH)
