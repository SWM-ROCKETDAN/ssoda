from rest_framework import serializers
from .models import EventUser
from .models import EventPost


class EventUserSerializer(serializers.Serializer):
    post_url = serializers.CharField(max_length=255)
    event_reward = serializers.JSONField()


class EventPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventPost
        fields = '__all__'

