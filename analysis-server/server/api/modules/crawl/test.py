import server.api.modules.crawl.instagram.crawl_instagram as ci
import server.secret.test_url as test_url
import pprint

tmp = ci.crawl_all_from_post_url(test_url.INSTAGRAM_TEST_URL[1])

pprint.pprint(tmp)
