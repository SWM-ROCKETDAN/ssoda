from server.secret import key
from urllib.parse import urlencode

API_KEY = key.PROXY_API_KEY


def get_proxy_url(url):
    payload = {'api_key': API_KEY, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


def get_instagram_user_url(sns_id):
    return 'https://www.instagram.com/' + sns_id
