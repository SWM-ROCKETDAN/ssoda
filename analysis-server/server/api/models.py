from django.db import models

# Create your models here.

class EventUser(models.Model):
    event_user_id = models.IntegerField(primary_key=True)
    sns_id = models.CharField(max_length=255)
    sns_type = models.CharField(max_length=255)
    sns_status = models.IntegerField()
    follow_count = models.IntegerField()

    update_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'event_user'


class EventPost(models.Model):
    event_post_id = models.IntegerField(primary_key=True)
    user_id = models.IntegerField()
    post_url = models.CharField(max_length=255)
    post_status = models.IntegerField()
    upload_date = models.DateTimeField()
    transition_date = models.DateTimeField(blank=True, null=True)
    like_count = models.IntegerField(blank=True, null=True)
    comment_count = models.IntegerField(blank=True, null=True)
    hashtags = models.CharField(max_length=255, blank=True, null=True)

    update_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'event_post'


