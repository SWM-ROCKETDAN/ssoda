from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost
from .models import Reward
from .models import EventRewards
from .models import Event
from .models import EventImages


class EventSerializer(serializers.ModelSerializer):
    event_images = serializers.SlugRelatedField(
        many=True,
        read_only=True,
        slug_field='images'
     )

    class Meta:
        model = Event
        fields = ['etype', 'id', 'finish_date', 'event_images']


class EventImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventImages
        fields = '__all__'


class EventRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventRewards
        fields = ['event', 'rewards']


class RewardSerializer(serializers.ModelSerializer):
    event_id = serializers.SlugRelatedField(
        read_only=True,
        slug_field='event_id'
     )

    class Meta:
        model = Reward
        fields = ['id', 'category', 'count', 'image', 'name', 'price', 'event_id']


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'
