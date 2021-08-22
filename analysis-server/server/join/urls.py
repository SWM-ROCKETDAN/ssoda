from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('posts/<int:pk>/', views.JoinPostView.as_view()),
    path('users/<int:pk>/', views.JoinUserView.as_view()),
    path('rewards/<int:pk>/', views.JoinRewardView.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
