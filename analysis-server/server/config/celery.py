from __future__ import absolute_import
from celery import Celery
from kombu.utils.url import safequote
from .key import AWS
import os

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')

aws_access_key = safequote(AWS.AWS_ACCESS_KEY)
aws_secret_key = safequote(AWS.AWS_SECRET_KEY)

broker_url = "sqs://{aws_access_key}:{aws_secret_key}@".format(
    aws_access_key=aws_access_key, aws_secret_key=aws_secret_key,
)

app = Celery('config',
             broker=broker_url,
             backend='rpc://',
             include=['join.tasks'])

app.config_from_object('django.conf:settings', namespace='CELERY')

app.autodiscover_tasks()
