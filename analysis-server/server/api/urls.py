from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from .views import join_crawl_views
from .views import join_reward_view
from .views import report_views

urlpatterns = [
    path('join/posts/<int:pk>/', join_crawl_views.JoinPostView.as_view()),
    path('join/users/<int:pk>/', join_crawl_views.JoinUserView.as_view()),
    path('join/rewards/<int:pk>/', join_reward_view.JoinRewardView.as_view()),
    path('reward/events/<int:pk>/', report_views.ReportEventView.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
