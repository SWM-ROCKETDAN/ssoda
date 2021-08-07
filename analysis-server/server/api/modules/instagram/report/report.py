from .report_assistant import get_report_dict


class EventReport:
    def __init__(self, join_list, event):
        self.join_list = join_list
        self.event = event

    def get_report_dict(self):
        return get_report_dict(self.join_list, self.event)
