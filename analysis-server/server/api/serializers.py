from rest_framework import serializers
from .models import JoinPost
from .models import JoinUser


class JoinSerializer(serializers.Serializer):
    url = serializers.CharField(max_length=255)
    event_id = serializers.IntegerField()
    event_reward = serializers.JSONField()


# class EventPostSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EventPost
#         fields = '__all__'
