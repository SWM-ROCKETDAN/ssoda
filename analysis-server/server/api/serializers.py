from rest_framework import serializers
from .models import JoinUser, JoinPost
from .models import Event, Reward, EventRewards
from .models import Hashtag, HashtagHashtags


class HashtagHashtagsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HashtagHashtags
        fields = '__all__'


class HashtagSerializer(serializers.ModelSerializer):
    hashtag_hashtags = HashtagHashtagsSerializer(many=True)

    class Meta:
        model = Hashtag
        fields = '__all__'


class RewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reward
        fields = ['id', 'category', 'count', 'image', 'name', 'price']


class EventRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventRewards
        fields = ['event', 'rewards']

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            reward = Reward.objects.filter(id=representation['rewards'])
        except Reward.DoesNotExist:
            pass

        reward_serializer = RewardSerializer(data=reward, many=True)
        reward_serializer.is_valid()
        if reward_serializer.data:
            representation['rewards'] = reward_serializer.data.pop()
        else:
            representation['reward'] = {}
        return representation


class EventSerializer(serializers.ModelSerializer):
    hashtag = HashtagSerializer()
    event_rewards = EventRewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'


class JoinCollectionSerializer(serializers.ModelSerializer):
    event = EventSerializer()

    class Meta:
        model = JoinPost
        fields = '__all__'

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_user = JoinUser.objects.filter(sns_id=representation['sns_id'])
        except Reward.DoesNotExist:
            pass

        join_user_serializer = JoinUserSerializer(data=join_user, many=True)
        join_user_serializer.is_valid()
        if join_user_serializer.data:
            representation['join_user'] = join_user_serializer.data.pop()
        else:
            representation['join_user'] = {}
        return representation


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'
