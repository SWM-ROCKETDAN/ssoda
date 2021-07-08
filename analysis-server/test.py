import json
import pprint
from urllib.request import urlopen
from urllib.parse import urlencode
from bs4 import BeautifulSoup
import config

API = config.API_LIST[1]
TEST_ID = 'sw_maestro'


def get_url(url):
    payload = {'api_key': API, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


post_url_list = ['https://www.instagram.com/p/CH7RveenG_B/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/Bx4bj61lL-30WS9r0J4hP_nWu4DUNumqYY4Uug0/?utm_medium=copy_link']

p_url = get_url(post_url_list[1])
response = urlopen(p_url)
soup = BeautifulSoup(response, "html.parser")
script_meta = str(soup.find('script', type='application/ld+json'))
likes = script_meta[script_meta.find('commentCount') + 12: script_meta.find('commentCount') + 22]
comments = script_meta[script_meta.find('userInteractionCount') + 20: script_meta.find('userInteractionCount') + 30]

# print(likes, comments)
# likes = re.findall("\d+", likes).pop()
# comments = re.findall("\d+", comments).pop()
#
# print(script_meta)
# print(likes, comments)

test = soup.find('script', type='application/ld+json').string
# print(1, test.text)
# print(2, test.contents)
print(type(test))
print(str(test))

test1 = test[test.find('{'):]

json_acceptable_string = test1.replace("'", "\"")
d = json.loads(json_acceptable_string)
print(d)
pprint.pprint(d)
if 'commentCount' in d:
    print(d['commentCount'])
else:
    print(0)

if 'interactionStatistic' in d:
    if 'userInteractionCount' in d['interactionStatistic']:
        print(d['interactionStatistic']['userInteractionCount'])
    else:
        print(0)

print(d['author']['alternateName'])