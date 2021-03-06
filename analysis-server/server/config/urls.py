"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.conf.urls import url, re_path
from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from django.conf.urls import include

# urlpatterns = [
#     url(r'^admin/', admin.site.urls),
#     url(r'^api/v1/join/', include('join.urls'), name='join'),
#     url(r'^api/v1/report/', include('report.urls'), name='report'),
#     url(r'^api/v1/rank/', include('rank.urls'), name='rank'),
# ]

urlpatterns = [
    re_path(r'^admin/', admin.site.urls),
    re_path(r'^api/v1/join/', include('join.urls'), name='join'),
    re_path(r'^api/v1/report/', include('report.urls'), name='report'),
    re_path(r'^api/v1/rank/', include('rank.urls'), name='rank'),
]
