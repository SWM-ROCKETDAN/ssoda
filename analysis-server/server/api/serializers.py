from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost
from .models import Reward
from .models import EventRewards


class RewardSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Reward
        field = '__all__'


class EventRewardSerializer(serializers.HyperlinkedModelSerializer):
    sub_rewards = RewardSerializer(many=True, read_only=True)

    class Meta:
        model = EventRewards
        fields = ['event', 'rewards', 'sub_rewards']


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'
