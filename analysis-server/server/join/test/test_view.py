from .test_setup import TestSetUp


class JoinPostViewTest(TestSetUp):
    def test_join_post_put_view(self):
        response = self.client.put(self.join_posts_url)

        self.assertEqual(response.status_code, 200)
