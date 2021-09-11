# This is an auto-generated Django model modules.
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
    deleted = models.BooleanField(null=True, default=False)

    class Meta:
        db_table = 'event'


class EventImages(models.Model):
    event = models.ForeignKey(Event, related_name='event_images', on_delete=models.CASCADE)
    images = models.CharField(max_length=255)

    class Meta:
        db_table = 'event_images'


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


class Reward(models.Model):
    category = models.IntegerField(blank=True, null=True)
    count = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=255)
    price = models.IntegerField(blank=True, null=True)
    level = models.BigIntegerField(blank=True, null=True)
    used_count = models.IntegerField(blank=True, null=True)
    event = models.ForeignKey(Event, related_name='rewards', on_delete=models.DO_NOTHING, blank=True, null=True)
    image_path = models.CharField(max_length=255, blank=True, null=True)
    deleted = models.BooleanField(null=True, default=False)

    class Meta:
        db_table = 'reward'


class Store(models.Model):
    id = models.BigAutoField(primary_key=True)
    city = models.CharField(max_length=255, blank=True, null=True)
    country = models.CharField(max_length=255, blank=True, null=True)
    road = models.CharField(max_length=255, blank=True, null=True)
    town = models.CharField(max_length=255, blank=True, null=True)
    zip_code = models.CharField(max_length=255, blank=True, null=True)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)
    category = models.IntegerField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    user = models.ForeignKey('User', models.DO_NOTHING, blank=True, null=True)
    logo_image_path = models.CharField(max_length=255, blank=True, null=True)
    building_code = models.CharField(max_length=255, blank=True, null=True)
    deleted = models.BooleanField(null=True, default=False)

    class Meta:
        db_table = 'store'


class StoreImages(models.Model):
    store = models.ForeignKey(Store, models.DO_NOTHING)
    images = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'store_images'


class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255)
    picture = models.CharField(max_length=255, blank=True, null=True)
    role = models.CharField(max_length=255)
    created_date = models.DateTimeField()
    modified_date = models.DateTimeField()
    password = models.CharField(max_length=255)
    provider = models.CharField(max_length=255)
    user_id = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'user'


class JoinPost(models.Model):
    id = models.BigAutoField(primary_key=True)
    event = models.ForeignKey(Event, related_name='event', on_delete=models.DO_NOTHING)
    reward = models.ForeignKey(Reward, related_name='reward', on_delete=models.DO_NOTHING, blank=True, null=True)
    sns_id = models.CharField(max_length=255, blank=True, null=True)
    url = models.CharField(max_length=255)
    type = models.IntegerField(blank=True, null=True)
    status = models.IntegerField(blank=True, null=True)
    like_count = models.IntegerField(blank=True, null=True, default=0)
    comment_count = models.IntegerField(blank=True, null=True, default=0)
    hashtags = models.CharField(max_length=255, blank=True, null=True, default='')
    create_date = models.DateTimeField()
    upload_date = models.DateTimeField(blank=True, null=True)
    private_date = models.DateTimeField(blank=True, null=True)
    delete_date = models.DateTimeField(blank=True, null=True)
    update_date = models.DateTimeField(blank=True, null=True)
    reward_date = models.DateTimeField(blank=True, null=True)
    deleted = models.BooleanField(null=True, default=False)

    class Meta:
        db_table = 'join_post'


class JoinUser(models.Model):
    id = models.BigAutoField(primary_key=True)
    sns_id = models.CharField(max_length=255)
    url = models.CharField(max_length=255, blank=True, null=True)
    type = models.IntegerField()
    status = models.IntegerField(blank=True, null=True)
    follow_count = models.IntegerField(blank=True, null=True, default=0)
    post_count = models.IntegerField(blank=True, null=True, default=0)
    create_date = models.DateTimeField()
    update_date = models.DateTimeField(blank=True, null=True)
    deleted = models.BooleanField(null=True, default=False)

    class Meta:
        db_table = 'join_user'


class TaskJoinPost(models.Model):
    id = models.BigAutoField(primary_key=True)
    join_post = models.ForeignKey(JoinPost, related_name='join_post', on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'task_join_post'
