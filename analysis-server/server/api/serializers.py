from rest_framework import serializers
from .models import JoinUser
from .models import JoinPost


class JoinPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = JoinPost
        fields = [
            'sns_id',
            'url',
            'type',
            'status',
            'like_count',
            'comment_count',
            'hashtags',
            'upload_date',
            'private_date',
            'delete_data',
            'update_date',
        ]

    def create(self, validated_data):
        return JoinPost.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.sns_id = validated_data.get('sns_id', instance.sns_id)
        instance.url = validated_data.get('type', instance.url)
        instance.type = validated_data.get('type', instance.type)
        instance.status = validated_data.get('status', instance.status)
        instance.like_count = validated_data.get('like_count', instance.like_count)
        instance.comment_count = validated_data.get('comment_count', instance.comment_count)
        instance.hashtags = validated_data.get('hashtags', instance.hashtags)
        instance.upload_date = validated_data.get('upload_date', instance.upload_date)
        instance.private_date = validated_data.get('private_date', instance.private_date)
        instance.delete_data = validated_data.get('delete_data', instance.delete_data)
        instance.update_date = validated_data.get('update_date', instance.update_date)
        instance.save()
        return instance


class JoinUserSerializer(serializers.Serializer):
    class Meta:
        model = JoinUser
        fields = [
            'sns_id',
            'url',
            'type',
            'status',
            'follow_count',
            'post_count',
            'update_date',
        ]

    def create(self, validated_data):
        pass

    def update(self, instance, validated_data):
        instance.sns_id = validated_data.get('sns_id', instance.sns_id)
        instance.url = validated_data.get('url', instance.url)
        instance.type = validated_data.get('type', instance.type)
        instance.status = validated_data.get('status', instance.status)
        instance.follow_count = validated_data.get('follow_count', instance.follow_count)
        instance.post_count = validated_data.get('post_count', instance.post_count)
        instance.update_date = validated_data.get('update_date', instance.update_date)
        instance.save()
        return instance
