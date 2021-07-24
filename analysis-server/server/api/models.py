# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class JoinPost(models.Model):
    event_id = models.IntegerField()
    sns_id = models.IntegerField(blank=True, null=True)
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


class JoinUser(models.Model):
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

