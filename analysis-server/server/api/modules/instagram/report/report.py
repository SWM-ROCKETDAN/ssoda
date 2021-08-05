import pprint
from .report_exposure import get_day_list, get_day_exposure_list


class EventReport:
    def __init__(self, join_collection_list, pk):
        self.join_collection_list = join_collection_list
        self.pk = pk

    def test(self):
        pprint.pprint("test코드 입니다.")
        get_day_exposure_list(self.join_collection_list)
