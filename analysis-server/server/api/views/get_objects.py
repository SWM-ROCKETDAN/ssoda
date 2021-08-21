from ..models import JoinPost
from ..models import JoinUser
from ..models import Event
from ..modules.config import custom_status
from rest_framework import status


def get_join_post(pk: int):
    try:
        return JoinPost.objects.get(pk=pk)
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_post_list() -> list:
    try:
        return JoinPost.objects.all()
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_post_by_event(event_id) -> list:
    try:
        return JoinPost.objects.filter(event=event_id)
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_user(pk: int):
    try:
        return JoinUser.objects.get(pk=pk)
    except JoinUser.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_event(pk):
    try:
        return Event.objects.get(pk=pk)
    except Event.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND

