from server.secret.config import Key
from urllib.parse import urlencode

API_KEY = Key.PROXY_API_KEY


def get_proxy_url(url):
    payload = {'api_key': API_KEY, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url
