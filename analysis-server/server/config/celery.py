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

CELERY_BROKER_TRANSPORT_OPTIONS = {
    'predefined_queues': {
        'celery': {
            'url': 'https://sqs.ap-northeast-2.amazonaws.com/083622219977/celery',
            'access_key_id': AWS.AWS_ACCESS_KEY,
            'secret_access_key': AWS.AWS_SECRET_KEY,
            'backoff_policy': {1: 10, 2: 20, 3: 40, 4: 80, 5: 320, 6: 640},
            'backoff_tasks': ['join.tasks'],
            'region': 'ap-northeast-2',
            'polling_interval': 3,
            'visibility_timeout': 300,

        },
    },
    # "queue_name_prefix": "celery-",
    # # "task-default-queue": "celery-v00-01",
    # 'backoff_policy': {1: 10, 2: 20, 3: 40, 4: 80, 5: 320, 6: 640},
    # 'backoff_tasks': ['join.tasks'],
    # 'region': 'ap-northeast-2',
    # 'polling_interval': 3,
    # 'visibility_timeout': 300,

}

app = Celery('config',
             broker=broker_url,
             backend='rpc://',
             include=['join.tasks'],
             broker_transport_options=CELERY_BROKER_TRANSPORT_OPTIONS)


app.config_from_object('django.conf:settings', namespace='CELERY')

app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')
