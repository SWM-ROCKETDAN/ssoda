from server.api.modules.join.instagram.crawl_instagram_post import do_crawl_post
from server.api.modules.join.instagram.crawl_instagram_user import do_crawl_user


def crawl_post(post_url):
    return do_crawl_post(post_url)


def crawl_user(user_url):
    return do_crawl_user(user_url)


def crawl_post_and_user(post_url):
    post_data, user_data = do_crawl_post(post_url)
    user_data.update(do_crawl_user('https://www.instagram.com/' + user_data['sns_id']))

    return post_data, user_data
