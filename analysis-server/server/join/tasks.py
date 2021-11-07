from celery import shared_task


@shared_task
def task_scrap_post(pk: int) -> bool:
    from core.models import JoinPost
    from .serializers import JoinPostSerializer
    from core.modules.join.post.post_scraper import PostScraper
    from core.modules.assist.time import _get_timedelta_from_now_to_target
    from core.modules.assist.time import _parse_from_str_time_to_date_time

    try:
        join_post = JoinPost.objects.get(pk=pk)
        join_post_serializer = JoinPostSerializer(join_post)
        update_date = _parse_from_str_time_to_date_time(join_post_serializer.data['update_date'])
        _timedelta = _get_timedelta_from_now_to_target(update_date)
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
