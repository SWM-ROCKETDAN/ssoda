from rest_framework import serializers
from .models import JoinPost
from .models import JoinUser


class JoinUserSerializer(serializers.Serializer):
    url = serializers.CharField(max_length=255)
    event_reward = serializers.JSONField()


# class EventPostSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EventPost
#         fields = '__all__'
