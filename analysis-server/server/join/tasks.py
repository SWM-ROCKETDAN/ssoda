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


def check_interval_day_is_over(target_day: int, target_date_time: datetime) -> bool:
    interval_day = get_interval_day_from_now_to_target_date_time(target_date_time)
    if interval_day > target_day:
        return True
    return False


def add_queue_after_check_post(pk: int, create_date: datetime, max_day: int, queue_day: int) -> None:
    # create_date = parse_from_str_time_to_date_time(create_date)
    # interval_day = get_interval_day_from_now_to_target_date_time(create_date)
    # if interval_day < max_day:
    #     queue_date_time = datetime.now() + timedelta(days=queue_day)
    #     task_scrap_post.apply_async((pk, max_day, queue_day), expires=queue_date_time)
    task_scrap_post.apply_async((pk, max_day, queue_day), expires=datetime.now() + timedelta(minutes=10))


def add_queue_after_check_user(pk: int, create_date: datetime, max_day: int, queue_day: int) -> None:
    # create_date = parse_from_str_time_to_date_time(create_date)
    # interval_day = get_interval_day_from_now_to_target_date_time(create_date)
    # if interval_day < max_day:
    #     queue_date_time = datetime.now() + timedelta(days=queue_day)
    #     task_scrap_user.apply_async((pk, max_day, queue_day), expires=queue_date_time)
    task_scrap_user.apply_async((pk, max_day, queue_day), expires=datetime.now() + timedelta(minutes=10))


@shared_task
def task_scrap_post(pk: int, max_day: int, queue_day: int) -> None:
    from core.models import JoinPost
    from .serializers import JoinPostSerializer
    from core.modules.join.post.post_scraper import PostScraper

    try:
        join_post = JoinPost.objects.get(pk=pk)
        join_post_update_serializer = JoinPostSerializer(join_post)
        post_scraper = PostScraper(join_post_update_serializer.data)
        scraped_post = post_scraper.get_scraped_post_only_do_scrap()
        join_post_serializer = JoinPostSerializer(join_post, scraped_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            print('진짜 잘했어 최고야.')
        # create_date = parse_from_str_time_to_date_time(join_post_serializer.data['create_date'])
        # interval_day = get_interval_day_from_now_to_target_date_time(create_date)
        # if interval_day < max_day:
        #     queue_date_time = datetime.now() + timedelta(days=queue_day)
        #     task_scrap_post.apply_async((pk, max_day, queue_day), expires=queue_date_time)
    # 에러 발생 시 task 를 무사히 탈출 한다.
    except Exception as e:
        print('힘내 할수있다고 생각해.. ')


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
