from rest_framework import serializers
from django.shortcuts import get_object_or_404
from core.models import EventReport


class EventReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventReport
        fields = '__all__'
