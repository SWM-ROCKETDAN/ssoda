from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path("events/participate/<int:limit>/", views.EventRankParticipate.as_view(), name="event_rank_participate"),
    path("events/react/<int:limit>/", views.EventRankReact.as_view(), name="event_rank_react"),
    path("events/guestprice/<int:limit>/", views.EventRankGuestPrice.as_view(), name="event_rank_guest_price")
]

urlpatterns = format_suffix_patterns(urlpatterns)
