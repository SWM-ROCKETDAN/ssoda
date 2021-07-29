# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models

class Event(models.Model):
    etype = models.CharField(max_length=31)
    id = models.BigAutoField(primary_key=True)
    finish_date = models.DateTimeField(blank=True, null=True)
    start_date = models.DateTimeField()
    status = models.IntegerField()
    title = models.CharField(max_length=255)
    store = models.ForeignKey('Store', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        db_table = 'event'


class EventImages(models.Model):
    event = models.ForeignKey(Event, related_name='event_images', on_delete=models.CASCADE)
    images = models.CharField(max_length=255)

    class Meta:
        db_table = 'event_images'


class EventRewards(models.Model):
    event = models.ForeignKey(Event, models.DO_NOTHING)
    rewards = models.OneToOneField('Reward', related_name='event_reward', on_delete=models.CASCADE)

    class Meta:
        db_table = 'event_rewards'


class Hashtag(models.Model):
    template = models.IntegerField()
    id = models.OneToOneField(Event, related_name='hashtag', on_delete=models.CASCADE, db_column='id', primary_key=True)

    class Meta:
        db_table = 'hashtag'


class HashtagHashtags(models.Model):
    hashtag = models.ForeignKey(Hashtag, related_name='hashtag_hashtags', on_delete=models.CASCADE)
    hashtags = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'hashtag_hashtags'


class HashtagRequirements(models.Model):
    hashtag = models.ForeignKey(Hashtag, models.DO_NOTHING)
    requirements = models.TextField()  # This field type is a guess.

    class Meta:
        db_table = 'hashtag_requirements'

class JoinUser(models.Model):
    id = models.BigAutoField(primary_key=True)
    sns_id = models.CharField(max_length=255)
    url = models.CharField(max_length=255, blank=True, null=True)
    type = models.IntegerField()
    status = models.IntegerField(blank=True, null=True)
    follow_count = models.IntegerField(blank=True, null=True)
    post_count = models.IntegerField(blank=True, null=True)
    create_date = models.DateTimeField()
    update_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'join_user'


class JoinPost(models.Model):
    id = models.BigAutoField(primary_key=True)
    event = models.ForeignKey(Event, models.DO_NOTHING)
    rewards_id = models.IntegerField(blank=True, null=True)
    sns_id = models.CharField(max_length=255, blank=True, null=True)
    url = models.CharField(max_length=255)
    type = models.IntegerField(blank=True, null=True)
    status = models.IntegerField(blank=True, null=True)
    like_count = models.IntegerField(blank=True, null=True)
    comment_count = models.IntegerField(blank=True, null=True)
    hashtags = models.CharField(max_length=255, blank=True, null=True)
    create_date = models.DateTimeField()
    upload_date = models.DateTimeField(blank=True, null=True)
    private_date = models.DateTimeField(blank=True, null=True)
    delete_data = models.DateTimeField(blank=True, null=True)
    update_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'join_post'


class Reward(models.Model):
    id = models.BigAutoField(primary_key=True)
    category = models.IntegerField(blank=True, null=True)
    count = models.IntegerField(blank=True, null=True)
    image = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255)
    price = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'reward'


class Store(models.Model):
    id = models.BigAutoField(primary_key=True)
    city = models.CharField(max_length=255, blank=True, null=True)
    country = models.CharField(max_length=255, blank=True, null=True)
    road = models.CharField(max_length=255, blank=True, null=True)
    road_code = models.CharField(max_length=12, blank=True, null=True)
    town = models.CharField(max_length=255, blank=True, null=True)
    zip_code = models.CharField(max_length=255, blank=True, null=True)
    category = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    name = models.CharField(max_length=255)

    class Meta:
        db_table = 'store'


class StoreImages(models.Model):
    store = models.ForeignKey(Store, models.DO_NOTHING)
    images = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'store_images'
