from server.api.modules.crawl.instagram.crawl_instagram_post import do_crawl_post
from server.api.modules.crawl.instagram.crawl_instagram_user import do_crawl_user


def crawl_post(post_url):
    return do_crawl_post(post_url)


def crawl_user(user_url):
    return do_crawl_user(user_url)


def crawl_all_from_post_url(post_url):
    post_data, user_url = do_crawl_post(post_url)
    user_data = do_crawl_user(user_url)

    return post_data, user_data
