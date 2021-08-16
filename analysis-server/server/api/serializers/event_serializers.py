from rest_framework import serializers
from ..models import Reward
from ..models import Event
from ..models import HashtagHashtags
from ..models import Hashtag


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
        fields = '__all__'


class EventSerializer(serializers.ModelSerializer):
    hashtag = HashtagSerializer()
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = '__all__'
