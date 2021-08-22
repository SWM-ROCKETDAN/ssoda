from rest_framework.views import APIView
from django.http import JsonResponse
from server.api.join_serializers import JoinPostSerializer
from server.api.join_serializers import JoinSerializer
from server.api.event_serializers import EventSerializer
from ..modules.instagram.join.reward.reward import JoinReward
from ..modules.config import custom_status
from .get_objects import get_join_post
from .get_objects import get_join_post_list
from .get_objects import get_event


# Reward GET 요청
class JoinRewardView(APIView):
    def get(self, request, pk):
        # Join List 가져오기
        try:
            join_post_list = get_join_post_list()
            join_list_serializer = JoinSerializer(data=join_post_list, many=True)
            join_list_serializer.is_valid()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_FOUND_ERROR)

        # Join 가져오기
        try:
            join_post = get_join_post(pk)
            join_serializer = JoinSerializer(join_post)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_FOUND_ERROR)

        # Event 가져오기
        try:
            event_id = join_serializer.data.get('event')
            event = get_event(event_id)
            event_serializer = EventSerializer(event)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.EVENT_FOUND_ERROR)

        # 리워드 id 계산
        try:
            join_reward = JoinReward(join_list_serializer.data, join_serializer.data, event_serializer.data)
            reward = join_reward.get_reward()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ServerError.JOIN_REWARD_ERROR)

        # Join Post 의 reward_id 값 업데이트
        join_post_serializer = JoinPostSerializer(join_post, {'reward': reward[0]}, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        # test
        return JsonResponse({'reward_id': reward[0]})
