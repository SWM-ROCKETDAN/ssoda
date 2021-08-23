from rest_framework.views import exception_handler
from . import exceptions


def custom_exception_handler(exc, context):
    handlers = {
        # OK
        exceptions.PostUpdateOk.__name__: exceptions.PostUpdateOk,
        exceptions.UserUpdateOk.__name__: exceptions.UserUpdateOk,
        # Client Error
        exceptions.PostIsPrivate.__name__: exceptions.PostIsPrivate,
        exceptions.PostIsDeleted.__name__: exceptions.PostIsDeleted,
        exceptions.PostIsDiffHashtag.__name__: exceptions.PostIsDiffHashtag,
        # Server Error
        exceptions.ProxyFailed.__name__: exceptions.ProxyFailed,
        exceptions.ScrapFailed.__name__: exceptions.ScrapFailed,
        exceptions.PostUpdateFailed.__name__: exceptions.PostUpdateFailed,
        exceptions.UserUpdateFailed.__name__: exceptions.UserUpdateFailed,
        exceptions.RewardCalculateFailed.__name__: exceptions.RewardCalculateFailed,
    }

    response = exception_handler(exc, context)
    exception_class = exc.__class__.__name__

    if exception_class in handlers:
        response.data.pop('detail', 1)
        response.data['message'] = handlers[exception_class].default_detail
        response.data['status'] = handlers[exception_class].status_code
        response.data['code'] = handlers[exception_class].default_code

    return response
