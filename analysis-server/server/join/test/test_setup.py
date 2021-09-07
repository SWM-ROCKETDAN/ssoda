from django.urls import reverse
from rest_framework.test import APITestCase
from core.models import Event
from core.models import JoinPost
from ..serializers import JoinPostSerializer
from ..serializers import EventSerializer
# from core.serializers import EventSerializer
from datetime import datetime


class TestSetUp(APITestCase):
    def setUp(self) -> None:
        print(EventSerializer.data)

        event = {
            'etype': 'hashtag',
            'status': 1,
            'start_date': datetime(2021, 9, 1),
            'finish_date': datetime(2022, 9, 1),
            'title': 'test hashtag event',
            'store': None,
            'rewards': [
                {
                    'category': 0,
                    'count': 100,
                    'name': '콜라',
                    'price': 500,
                    'level': 1,
                    'used_count': 0,
                },
                {
                    'category': 1,
                    'count': 1000,
                    'name': '샌드위치',
                    'price': 2000,
                    'level': 2,
                    'used_count': 0,
                }
            ],
            'hashtag': {
                'hashtag_hashtags': [
                    {

                    }
                ]

            }
        }
        event_serializer = EventSerializer(data=event)
        self.assertEqual(event_serializer.is_valid(), True)
        if event_serializer.is_valid():
            event_serializer.save()

        join_post = {
            'event': 1,
            'reward': None,
            'sns_id': "test_sns_id",
            'url': 'test_url',
            'type': 0,
            'status': 0,
            'like_count': 100,
            'comment_count': 100,
            'hashtags': 'test_hashtags',
            'create_date': datetime(2021, 9, 1),
            'upload_date': datetime(2021, 9, 2),
            'delete_date': None,
            'reward_date': datetime(2021, 9, 3),
        }
        join_post_serializer = JoinPostSerializer(data=join_post)
        # self.assertEqual(join_post_serializer.is_valid(), True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        else:
            join_post_serializer.errors()

        self.join_posts_url = reverse('join_posts', args=[1])
        self.join_users_url = reverse('join_users', args=[1])
        self.join_rewards_url = reverse('join_rewards', args=[1])
