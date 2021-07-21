from server.api.models import JoinPost


def save_join_post(post: dict):
    model = JoinPost(**post)

    pass
