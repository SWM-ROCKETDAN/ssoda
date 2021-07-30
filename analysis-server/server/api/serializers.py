import pprint

from rest_framework import serializers
from rest_framework.utils import json

from .models import JoinUser
from .models import JoinPost
from .models import Reward
from .models import EventRewards
from .models import Event
from .models import EventImages
from .models import HashtagHashtags
from .models import Hashtag


class HashtagHashtagsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HashtagHashtags
        fields = '__all__'


class HashtagSerializer(serializers.ModelSerializer):
    hashtag_hashtags = HashtagHashtagsSerializer(many=True)

    class Meta:
        model = Hashtag
        fields = '__all__'


class EventSerializer(serializers.ModelSerializer):
    hashtag = HashtagSerializer()

    class Meta:
        model = Event
        fields = '__all__'


class EventRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventRewards
        fields = ['event', 'rewards']


class RewardSerializer(serializers.ModelSerializer):
    event_reward = EventRewardSerializer()

    class Meta:
        model = Reward
        fields = ['id', 'category', 'count', 'image', 'name', 'price', 'event_reward']


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

# class JoinCollectionSerializer(serializers.Serializer):
#     id = serializers.IntegerField()
#     event_id = serializers.IntegerField()
#     rewards_id = serializers.IntegerField()
#     sns_id = serializers.CharField()
#     url = serializers.CharField()
#     type = serializers.IntegerField()
#     status = serializers.IntegerField()
#     like_count = serializers.IntegerField()
#     comment_count = serializers.IntegerField()
#     hashtags = serializers.CharField()
#     create_date = serializers.DateTimeField()
#     upload_date = serializers.DateTimeField()
#     private_date = serializers.DateTimeField()
#     delete_data = serializers.DateTimeField()
#     update_date = serializers.DateTimeField()
#     follow_count = serializers.IntegerField()
#     post_count = serializers.IntegerField()
#     event_hashtags = serializers.CharField()
