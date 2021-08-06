# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Event(models.Model):
    etype = models.CharField(max_length=31)
    id = models.BigAutoField(primary_key=True)
    finish_date = models.DateTimeField(blank=True, null=True)
    start_date = models.DateTimeField()
    status = models.IntegerField()
    title = models.CharField(max_length=255)
    store = models.ForeignKey('Store', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'event'


class EventImages(models.Model):
    id = models.BigAutoField(primary_key=True)
    images = models.CharField(max_length=255)
    event = models.ForeignKey(Event, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'event_images'


class EventRewards(models.Model):
    id = models.BigAutoField(primary_key=True)
    event = models.ForeignKey(Event, models.DO_NOTHING)
    rewards = models.OneToOneField('Reward', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'event_rewards'


class Hashtag(models.Model):
    template = models.IntegerField()
    id = models.OneToOneField(Event, models.DO_NOTHING, db_column='id', primary_key=True)

    class Meta:
        managed = False
        db_table = 'hashtag'


class HashtagHashtags(models.Model):
    id = models.BigAutoField(primary_key=True)
    hashtags = models.CharField(max_length=255, blank=True, null=True)
    hashtag = models.ForeignKey(Hashtag, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'hashtag_hashtags'


class HashtagRequirements(models.Model):
    id = models.BigAutoField(primary_key=True)
    requirements = models.TextField()
    hashtag = models.ForeignKey(Hashtag, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'hashtag_requirements'


class JoinPost(models.Model):
    id = models.BigAutoField(primary_key=True)
    rewards_level = models.IntegerField(blank=True, null=True)
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
    update_date = models.DateTimeField(blank=True, null=True)
    event = models.ForeignKey(Event, models.DO_NOTHING)
    delete_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'join_post'


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
        managed = False
        db_table = 'join_user'


class Reward(models.Model):
    id = models.BigAutoField(primary_key=True)
    category = models.IntegerField(blank=True, null=True)
    count = models.IntegerField(blank=True, null=True)
    image = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255)
    price = models.IntegerField(blank=True, null=True)
    level = models.BigIntegerField(blank=True, null=True)
    used_count = models.IntegerField(blank=True, null=True)
    event = models.ForeignKey(Event, models.DO_NOTHING, blank=True, null=True)

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
    user = models.ForeignKey('User', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'store'


class StoreImages(models.Model):
    id = models.BigAutoField(primary_key=True)
    images = models.CharField(max_length=255, blank=True, null=True)
    store = models.ForeignKey(Store, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'store_images'


class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    picture = models.CharField(max_length=255, blank=True, null=True)
    role = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'user'
