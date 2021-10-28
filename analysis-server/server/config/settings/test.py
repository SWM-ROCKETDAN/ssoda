from .base import *
from kombu.utils.url import safequote

DEBUG = True

ALLOWED_HOSTS = ["*"]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': get_secret("RDS_DEV_SSODA_NAME"),
        'USER': get_secret("RDS_SSODA_USER"),
        'PASSWORD': get_secret("RDS_SSODA_PASSWORD"),
        'HOST': get_secret("RDS_SSODA_HOST"),
        'PORT': get_secret("RDS_SSODA_PORT"),
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
        },
        'TEST': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'dev_ssoda_database',
        }
    },
}

REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 10,
    'EXCEPTION_HANDLER': 'core.exceptions.exception_handler.custom_exception_handler'
}

ROOT_URLCONF = 'config.urls'

CELERY_BROKER_URL = "sqs://{aws_access_key}:{aws_secret_key}@".format(
    aws_access_key=safequote(get_secret('AWS_ACCESS_KEY')), aws_secret_key=safequote(get_secret('AWS_SECRET_KEY')),
)

CELERY_BROKER_TRANSPORT_OPTIONS = {
    'region': 'ap-northeast-2',
    'visibility_timeout': 3600,
    'polling_interval': 10,
    'queue_name_prefix': '%s-' % {
        True: 'dev',
        False: 'production'}[DEBUG],
    'CELERYD_PREFETCH_MULTIPLIER': 0,
}
