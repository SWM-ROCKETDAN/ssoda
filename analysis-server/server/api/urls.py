from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('join/posts/<int:pk>/', views.JoinPostView.as_view()),
    path('join/users/<int:pk>/', views.JoinUserView.as_view()),
    path('join/rewards/<int:pk>/', views.JoinRewardView.as_view()),
    path('report/events/<int:pk>/', views.ReportEventView.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
