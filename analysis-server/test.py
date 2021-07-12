import json
import pprint
from urllib.request import urlopen
from urllib.parse import urlencode
from bs4 import BeautifulSoup
import config

API = config.API_LIST[0]
TEST_ID = 'sw_maestro'


def get_url(url):
    payload = {'api_key': API, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


post_url_list = ['https://www.instagram.com/p/CH7RveenG_B/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/Bx4bj61lL-30WS9r0J4hP_nWu4DUNumqYY4Uug0/?utm_medium=copy_link']

p_url = get_url('https://www.instagram.com/sw_maestro/following/')
response = urlopen(p_url)
soup = BeautifulSoup(response, "html.parser")
print(soup)