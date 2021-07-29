from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('join/post/<int:pk>/', views.JoinPostView.as_view()),
    path('join/user/<int:pk>/', views.JoinUserView.as_view()),
    path('join/reward/<int:pk_event>/<int:pk_post>/<int:pk_user>/', views.JoinRewardView.as_view()),
    path('test/<pk>/', views.TestApi.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
