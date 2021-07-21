from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinSerializer(serializers.Serializer):
    url = serializers.CharField(max_length=255)
    event_id = serializers.IntegerField()
    event_reward = serializers.JSONField()

# class EventPostSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EventPost
#         fields = '__all__'
