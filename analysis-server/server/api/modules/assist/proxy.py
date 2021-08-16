from server.secret.config import Key
from urllib.parse import urlencode

API_KEY = Key.PROXY_API_KEY
API_KEY = 'ae226896-a37e-413f-a1d6-a75ba0d2f8a0'


def get_url(url):
    payload = {'api_key': API_KEY, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url
