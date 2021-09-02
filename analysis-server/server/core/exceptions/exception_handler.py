from rest_framework.views import exception_handler
from . import exceptions


# DRF Custom Exception Handler
def custom_exception_handler(exc, context):
    # Handling 딕셔너리
    handlers = {
        # Django Exception
        'Http404': parse_django_exception,

        # OK
        exceptions.PostUpdateOk.__name__: parse_custom_exception,
        exceptions.UserUpdateOk.__name__: parse_custom_exception,
        exceptions.RewardCalculateOK.__name__: parse_custom_exception,
        exceptions.EventReportCalculateOK.__name__: parse_custom_exception,
        exceptions.StoreReportCalculateOK.__name__: parse_custom_exception,
        exceptions.PostIsAlreadyCalculatedRewardAndOK.__name__: parse_custom_exception,
        exceptions.UserUpdateDontButOK.__name__: parse_custom_exception,

        # Client Error
        exceptions.PostIsPrivate.__name__: parse_custom_exception,
        exceptions.PostIsDeleted.__name__: parse_custom_exception,
        exceptions.PostIsDiffHashtag.__name__: parse_custom_exception,
        exceptions.PostIsAlreadyRewarded.__name__: parse_custom_exception,
        exceptions.PostEventIsNotOK.__name__: parse_custom_exception,

        # Server Error
        exceptions.ProxyFailed.__name__: parse_custom_exception,
        exceptions.ScrapFailed.__name__: parse_custom_exception,
        exceptions.PostUpdateFailed.__name__: parse_custom_exception,
        exceptions.UserUpdateFailed.__name__: parse_custom_exception,
        exceptions.RewardCalculateFailed.__name__: parse_custom_exception,
        exceptions.EventReportCalculateFailed.__name__: parse_custom_exception,
        exceptions.StoreReportCalculateFailed.__name__: parse_custom_exception,
    }

    response = exception_handler(exc, context)
    exception_class = exc.__class__.__name__
    print(exception_class)
    print(exc)
    print(response)
    # Handler 함수 적용
    if exception_class in handlers:
        response = handlers[exception_class](response, exc)
    else:
        response = parse_unknown_exception(response, exc)

    return response


# Custom Exception Handler 함수
def parse_custom_exception(response, exc):
    response.data.pop('detail', 1)
    response.data['message'] = exc.default_detail
    response.data['status'] = exc.status_code
    response.data['code'] = exc.default_code
    response.data['data'] = exc.data

    return response


# Django Exception handler 함수
def parse_django_exception(response, exc):
    django_exception = {
        'Http404': exceptions.Http404
    }

    exception_class = exc.__class__.__name__

    if exception_class in django_exception:
        response.data.pop('detail', 1)
        response.data['message'] = django_exception[exception_class].default_detail
        response.data['status'] = django_exception[exception_class].status_code
        response.data['code'] = django_exception[exception_class].default_code
        response.data['data'] = {}

    return response


# 정의되지 않은 Exception Handler 함수
def parse_unknown_exception(response, exc):
    response.data['message'] = response.data['detail']
    response.data['status'] = response.status_code
    response.data['code'] = 'SERVER_ERROR_999'
    response.data['data'] = {}
    response.data.pop('detail', 1)

    return response
