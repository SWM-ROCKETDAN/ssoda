from django.shortcuts import get_object_or_404
from rest_framework import serializers
from core.serializers import RewardSerializer
from core.serializers import EventRewardSerializer
from core.serializers import EventHashtagRewardSerializer
from core.serializers import JoinPostSerializer
from core.serializers import JoinUserSerializer
from core.models import Reward
from core.models import Event
from core.models import HashtagHashtags
from core.models import Hashtag
from core.models import JoinUser
from core.models import JoinPost


class JoinPostUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'


class JoinPostScrapSerializer(JoinPostSerializer):
    event = EventHashtagRewardSerializer()
    reward = RewardSerializer()

    # 해시태그 리스트 파싱
    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            event_hashtags = []
            event_hashtag_hashtag_hashtags = representation['event']['hashtag']['hashtag_hashtags']
            if event_hashtag_hashtag_hashtags is not None:
                for event_hashtag in event_hashtag_hashtag_hashtags:
                    event_hashtag = event_hashtag['hashtags'].upper()
                    event_hashtags.append(event_hashtag)
            representation['event_hashtags'] = event_hashtags
        except Exception as e:
            representation['event_hashtags'] = []
        try:
            post_hashtags = []
            for post_hashtag in representation['hashtags'].split(','):
                post_hashtag = post_hashtag.upper()
                post_hashtags.append(post_hashtag)
            representation['hashtags'] = post_hashtags
        except Exception as e:
            representation['hashtags'] = []
        return representation


class JoinUserScrapSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = "__all__"


class JoinUserFollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = ["follow_count", ]


class JoinRewardFollowCalculatorSerializer(serializers.ModelSerializer):
    event = EventRewardSerializer()

    class Meta:
        model = JoinPost
        fields = ["event", "sns_id", "type"]

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_user = JoinUser.objects.get(sns_id=representation["sns_id"], type=representation["type"])
            join_user_serializer = JoinUserFollowSerializer(join_user)
            follow_count = join_user_serializer.data["follow_count"]
        except JoinUser.DoesNotExist:
            follow_count = 0
        representation["follow_count"] = follow_count

        return representation


class JoinRewardRandomCalculatorSerializer(serializers.ModelSerializer):
    event = EventRewardSerializer()

    class Meta:
        model = JoinPost
        fields = ['event', ]
