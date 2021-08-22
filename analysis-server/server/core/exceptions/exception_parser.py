def parse_exception(exception):
    _exception = {
        'message': exception.default_detail,
        'status': exception.status_code,
        'code': exception.default_code
    }
    return _exception
