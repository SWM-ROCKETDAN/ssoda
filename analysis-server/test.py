from urllib.request import urlopen
from urllib.parse import urlencode
from lxml import etree
from lxml.etree import ParserError
import config
import requests

API = config.API_LIST[3]
TEST_ID = 'sw_maestro'


def get_url(url):
    payload = {'api_key': API, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


p_url = get_url('https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link')
response = requests.get(p_url)
html_doc = response.content

try:
    parser = etree.HTMLParser()
    html_dom = etree.HTML(html_doc, parser)
except ParserError as e:
    print(e)

# /html/body/div[1]/section/main/div/div[1]/article/div[3]/section[2]/div/div/a
urls = html_dom.xpath(
    '/html/body/div[1]')

print(html_doc)
print(html_dom)
print(urls)
