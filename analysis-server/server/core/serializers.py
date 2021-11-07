from rest_framework import serializers
from core.models import Reward
from core.models import Event
from core.models import HashtagHashtags
from core.models import Hashtag
from core.models import JoinUser
from core.models import JoinPost


class HashtagHashtagsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HashtagHashtags
        fields = ['hashtags']


class HashtagSerializer(serializers.ModelSerializer):
    hashtag_hashtags = HashtagHashtagsSerializer(many=True)

    class Meta:
        model = Hashtag
        fields = ['hashtag_hashtags']


class RewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reward
        fields = ['id', 'count', 'level', 'used_count', 'deleted']


class EventHashtagSerializer(serializers.ModelSerializer):
    hashtag = HashtagSerializer()
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'


class EventRewardSerializer(serializers.ModelSerializer):
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'


class EventHashtagRewardSerializer(serializers.ModelSerializer):
    hashtag = HashtagSerializer()
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'
