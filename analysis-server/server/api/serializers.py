from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = '__all__'

    def create(self, validated_data):
        return JoinPost.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.status = validated_data.get('status', instance.status)
        instance.upload_date = validated_data.get('upload_date', instance.upload_date)
        instance.private_date = validated_data.get('private_date', instance.private_date)
        instance.delete_data = validated_data.get('delete_data', instance.delete_data)
        instance.like_count = validated_data.get('like_count', instance.like_count)
        instance.comment_count = validated_data.get('comment_count', instance.comment_count)
        instance.hashtags = validated_data.get('hashtags', instance.hashtags)
        instance.update_date = validated_data.get('update_date', instance.upload_date)
        instance.save()
        return instance


class JoinSerializer(serializers.Serializer):
    url = serializers.CharField(max_length=255)
    event_id = serializers.IntegerField()
    event_reward = serializers.JSONField()

# class EventPostSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = EventPost
#         fields = '__all__'
