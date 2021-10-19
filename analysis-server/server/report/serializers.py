from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework import serializers
from core.models import Reward
from core.models import Event
from core.models import Store
from core.models import HashtagHashtags
from core.models import Hashtag
from core.models import EventReport
from core.models import JoinUser
from core.models import JoinPost


class EventReportUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventReport
        fields = "__all__"


class RewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reward
        fields = ["level", "count", "price", "used_count"]


class EventSerializer(serializers.ModelSerializer):
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = "__all__"


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = "__all__"


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = ["follow_count", ]


class JoinPostAndUserSerializer(serializers.ModelSerializer):
    reward = RewardSerializer()

    class Meta:
        model = JoinPost
        fields = "__all__"

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_user = JoinUser.objects.get(sns_id=representation["sns_id"], type=representation["type"])
            join_user_serializer = JoinUserSerializer(join_user)
            _join_user = join_user_serializer.data
        except JoinUser.DoesNotExist:
            _join_user = {}

        representation["join_user"] = _join_user

        return representation


class ReportEventSerializer(serializers.ModelSerializer):
    rewards = RewardSerializer(many=True)

    class Meta:
        model = Event
        fields = "__all__"

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_posts = JoinPost.objects.filter(event_id=representation["id"])
            join_post_and_user_serializer = JoinPostAndUserSerializer(data=join_posts, many=True)
            join_post_and_user_serializer.is_valid()
            _join_posts = join_post_and_user_serializer.data
        except JoinPost.DoesNotExist:
            _join_posts = {}

        representation["join_posts"] = _join_posts

        return representation


class ReportStoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Store
        fields = "__all__"

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            events = Event.objects.filter(store_id=representation["id"])
            report_event_serializer = ReportEventSerializer(data=events, many=True)
            report_event_serializer.is_valid()
            _events = report_event_serializer.data
        except Event.DoesNotExist:
            _events = []

        representation["events"] = _events

        return representation
