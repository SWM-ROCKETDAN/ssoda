from rest_framework import serializers
from core.models import Reward
from core.models import Event
from core.models import HashtagHashtags
from core.models import Hashtag
from core.models import JoinUser
from core.models import JoinPost


class RewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reward
        fields = ['count', 'price', 'used_count']


class EventSerializer(serializers.ModelSerializer):
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'


class ThisJoinSerializer(serializers.ModelSerializer):
    reward = RewardSerializer()

    class Meta:
        model = JoinPost
        fields = [
            'reward', 'event', 'sns_id',
            'type', 'status', 'like_count', 'comment_count',
            'hashtags', 'upload_date', 'private_date', 'delete_date',
        ]

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_user = JoinUser.objects.get(sns_id=representation['sns_id'], type=representation['type'])
        except JoinUser.DoesNotExist:
            join_user = {
                'follow_count': 0,
            }
        join_user_serializer = JoinUserSerializer(join_user)
        representation['join_user'] = join_user_serializer.data

        return representation


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = ['follow_count']
