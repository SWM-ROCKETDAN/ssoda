from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost
from .models import Reward
from .models import Event
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


class JoinSerializer(serializers.ModelSerializer):
    reward = RewardSerializer()

    class Meta:
        model = JoinPost
        fields = '__all__'

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            join_user = JoinUser.objects.get(sns_id=representation['sns_id'], type=representation['type'])
        except Exception as e:
            print(e)
            join_user = {
                'id': 0,
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
        fields = '__all__'
