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
    template = models.IntegerField()
    store = models.ForeignKey('Store', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'event'


class EventImages(models.Model):
    event = models.ForeignKey(Event, models.DO_NOTHING)
    images = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'event_images'


class EventRewards(models.Model):
    event = models.ForeignKey(Event, models.DO_NOTHING)
    rewards = models.OneToOneField('Reward', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'event_rewards'


class HashtagHashtags(models.Model):
    hashtag = models.ForeignKey(Event, models.DO_NOTHING)
    hashtags = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'hashtag_hashtags'


class HashtagRequirements(models.Model):
    hashtag = models.ForeignKey(Event, models.DO_NOTHING)
    requirements = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'hashtag_requirements'


class Reward(models.Model):
    id = models.BigAutoField(primary_key=True)
    category = models.IntegerField(blank=True, null=True)
    count = models.IntegerField(blank=True, null=True)
    image = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255)
    price = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
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
        managed = False
        db_table = 'store'


class StoreImages(models.Model):
    store = models.ForeignKey(Store, models.DO_NOTHING)
    images = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'store_images'

class JoinPost(models.Model):