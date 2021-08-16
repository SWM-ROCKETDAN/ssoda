from rest_framework.exceptions import APIException


class ErrorForm(APIException):
    status_code = 10
    default_code = ''
    default_detail = ''

    def __init__(self, status_code, default_detail, default_code):
        self.status_code = status_code
        self.default_detail = default_detail
        self.default_code = default_code

    # def get_object(self):
    #     obj = {
    #         'message': self.default_detail,
    #         'status': self.status_code,
    #         'code': self.default_code
    #     }
    #     return obj
