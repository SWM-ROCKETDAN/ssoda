from rest_framework import serializers
from ..core.models import JoinUser
from ..core.models import JoinPost
from server.api.event_serializers import RewardSerializer


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
