from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('events/<int:pk>/', views.ReportEvent.as_view()),
    path('stores/<int:pk>/', views.ReportStore.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
