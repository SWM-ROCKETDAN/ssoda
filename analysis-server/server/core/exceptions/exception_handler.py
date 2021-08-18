from rest_framework.views import exception_handler
import exceptions


def custom_exception_handler(exc, context):
    handlers = {
        exceptions.ProxyDenied.__class__.__name__: exceptions.ProxyDenied,
        exceptions.CrawlDenied.__class__.__name__: exceptions.CrawlDenied,
        exceptions.PostIsPrivate.__class__.__name__: exceptions.PostIsPrivate,
        exceptions.PostIsDiffHashtag.__class__.__name__: exceptions.PostIsDiffHashtag,
    }

    response = exception_handler(exc, context)
    exception_class = exc.__class__.__name__

    if response is not None:
        if exception_class in handlers:
            response.data.pop('detail', 1)
            response.data['message'] = handlers[exception_class].default_detail
            response.data['status'] = handlers[exception_class].status_code
            response.data['code'] = handlers[exception_class].default_code
    return response
