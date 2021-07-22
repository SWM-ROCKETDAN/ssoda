from server.api.modules.instagram.join.crawl.crawl_instagram_post import crawl_post
from server.api.modules.instagram.join.crawl.crawl_instagram_user import crawl_user


def crawl_post(post_url):
    return crawl_post(post_url)


def crawl_user(user_url):
    return crawl_user(user_url)


def crawl_all(post_url):
    post_data, user_data = crawl_post(post_url)
    user_data.update(crawl_user('https://www.instagram.com/' + user_data['sns_id']))

    return post_data, user_data
