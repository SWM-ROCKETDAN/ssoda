from rest_framework import serializers
from .models import EventUser
from .models import EventPost


class EventUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventUser
        fields = '__all__'


class EventPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPost
        fields = '__all__'

