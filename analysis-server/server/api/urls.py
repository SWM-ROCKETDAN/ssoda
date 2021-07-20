from django.urls import path
from . import views

urlpatterns = [
    path('events/users/', views.JoinView.as_view()),
]