from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('posts/<int:pk>/', views.JoinPostsView.as_view(), name='join_posts'),
    path('users/<int:pk>/', views.JoinUsersView.as_view(), name='join_users'),
    path('rewards/<int:pk>/', views.JoinRewardsView.as_view(), name='join_rewards'),
]

urlpatterns = format_suffix_patterns(urlpatterns)
