from rest_framework.views import exception_handler
from . import exceptions


def custom_exception_handler(exc, context):
    handlers = (
        # OK
        exceptions.PostUpdateOk.__name__,
        exceptions.UserUpdateOk.__name__,
        exceptions.RewardCalculateOK.__name__,
        exceptions.EventReportCalculateOK.__name__,
        exceptions.StoreReportCalculateOK.__name__,
        exceptions.PostUpdateDontButOK.__name__,
        exceptions.UserUpdateDontButOK.__name__,
        # Client Error
        exceptions.PostIsPrivate.__name__,
        exceptions.PostIsDeleted.__name__,
        exceptions.PostIsDiffHashtag.__name__,
        # Server Error
        exceptions.ProxyFailed.__name__,
        exceptions.ScrapFailed.__name__,
        exceptions.PostUpdateFailed.__name__,
        exceptions.UserUpdateFailed.__name__,
        exceptions.RewardCalculateFailed.__name__,
        exceptions.EventReportCalculateFailed.__name__,
        exceptions.StoreReportCalculateFailed.__name__,
    )

    response = exception_handler(exc, context)
    exception_class = exc.__class__.__name__

    if exception_class in handlers:
        response.data.pop('detail', 1)
        response.data['message'] = exc.default_detail
        response.data['status'] = exc.status_code
        response.data['code'] = exc.default_code
        response.data['data'] = exc.data

    return response
