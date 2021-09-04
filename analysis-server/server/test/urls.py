from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [
    path('join/posts/', views.TestJoinPostView.as_view()),
    path('join/users/', views.TestJoinUserView.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
