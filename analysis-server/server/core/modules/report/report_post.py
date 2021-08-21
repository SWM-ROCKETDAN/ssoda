from server.secret.config import Status


def get_post_count():
    return 1


def get_deleted_post_count(status: int):
    if status == Status.DELETED:
        return 1
    return 0


def get_private_post_count(status: int):
    if status == Status.PRIVATE:
        return 1
    return 0
