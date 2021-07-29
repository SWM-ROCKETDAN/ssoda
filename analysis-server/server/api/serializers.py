from rest_framework import serializers
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

# class EventSerializer(serializers.ModelSerializer):
#     event_images = serializers.SlugRelatedField(
#         many=True,
#         read_only=True,
#         slug_field='images'
#     )
#
#     class Meta:
#         model = Event
#         fields = ['etype', 'id', 'finish_date', 'event_images']
#
#
# class EventImagesSerializer(serializers.RelatedField):
#     class Meta:
#         model = EventImages
#         fields = '__all__'


class EventRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventRewards
        fields = ['event', 'rewards']


class RewardSerializer(serializers.ModelSerializer):
    event_reward = EventRewardSerializer()

    class Meta:
        model = Reward
        fields = ['id', 'category', 'count', 'image', 'name', 'price', 'event_reward']


class JoinSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    event_id = serializers.IntegerField()
    rewards_id = serializers.IntegerField()
    sns_id = serializers.CharField()
    url = serializers.CharField()
    type = serializers.IntegerField()
    status = serializers.IntegerField()
    like_count = serializers.IntegerField()
    comment_count = serializers.IntegerField()
    hashtags = serializers.CharField()
    create_date = serializers.DateTimeField()
    upload_date = serializers.DateTimeField()
    private_date = serializers.DateTimeField()
    delete_data = serializers.DateTimeField()
    update_date = serializers.DateTimeField()
    follow_count = serializers.IntegerField()
    post_count = serializers.IntegerField()
    event_hashtags = serializers.CharField()


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'


class JoinUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinUser
        fields = '__all__'
