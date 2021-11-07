from rest_framework.exceptions import APIException

class CustomException(APIException):
    def __init__(self, data=None):
        super().__init__()
        if data is None:
            data = {}
        self.data = data