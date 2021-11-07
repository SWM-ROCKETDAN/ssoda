from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('events/<int:pk>/', views.ReportEvent.as_view(), name="report_events"),
    path('stores/<int:pk>/', views.ReportStore.as_view(), name="report_stores"),
]

urlpatterns = format_suffix_patterns(urlpatterns)
