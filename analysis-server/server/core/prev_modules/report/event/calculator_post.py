from server.core.modules.static.common import Status


def calculate_public_post_count(post_status):
    if post_status is None:
        return 0
    if post_status == Status.PUBLIC:
        return 1
    return 0


def calculate_private_post_count(post_status):
    if post_status is None:
        return 0
    if post_status == Status.PRIVATE:
        return 1
    return 0


def calculate_deleted_post_count(post_status):
    if post_status is None:
        return 0
    if post_status == Status.DELETED:
        return 1
    return 0
