from celery import shared_task
from core.models import JoinPost
from core.models import JoinUser
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer
from core.modules.join.post.post_scraper import PostScraper
from core.modules.join.user.user_scraper import UserScraper
from core.modules.assist.time import get_interval_day_from_now_to_target_date_time
from core.modules.assist.time import parse_from_str_time_to_date_time
from datetime import datetime
from datetime import timedelta


@shared_task
def task_scrap_post(pk: int) -> bool:
    from core.models import JoinPost
    from .serializers import JoinPostSerializer
    from core.modules.join.post.post_scraper import PostScraper
    from core.modules.assist.time import get_timedelta_from_now_to_target
    from core.modules.assist.time import parse_from_str_time_to_date_time

    try:
        join_post = JoinPost.objects.get(pk=pk)
        join_post_serializer = JoinPostSerializer(join_post)
        update_date = parse_from_str_time_to_date_time(join_post_serializer.data['update_date'])
        _timedelta = get_timedelta_from_now_to_target(update_date)
        if (_timedelta.seconds / 3600) < 10:
            # print('아직 10시간이 안지났어요!', _timedelta.seconds / 3600)
            return False
        # print('10시간이 지났군요!', _timedelta.seconds / 3600)
        post_scraper = PostScraper(join_post_serializer.data)
        scraped_post = post_scraper.get_scraped_post_only_do_scrap()
        join_post_serializer = JoinPostSerializer(join_post, scraped_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            return False
            # print('진짜 잘했어 최고야.')
    # 에러 발생 시 task 를 무사히 탈출 한다.
    except Exception as e:
        pass
        # print('힘내 할수있다고 생각해.. ')


@shared_task
def task_scrap_user(pk: int, max_day: int, queue_day: int) -> bool:
    try:
        join_user = JoinUser.objects.get(pk=pk)
        join_user_update_serializer = JoinUserSerializer(join_user)
        user_scraper = UserScraper(join_user_update_serializer.data)
        scraped_user = user_scraper.get_scraped_user()
        join_user_serializer = JoinUserSerializer(join_user, scraped_user, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            create_date = parse_from_str_time_to_date_time(join_user_serializer.data['create_date'])
            interval_day = get_interval_day_from_now_to_target_date_time(create_date)
            if interval_day < max_day:
                queue_date_time = datetime.now() + timedelta(days=queue_day)
                task_scrap_user.apply_async((pk, max_day, queue_day), expires=queue_date_time)
    except Exception as e:
        pass
    return True


@shared_task
def task_test():
    print('hello')
