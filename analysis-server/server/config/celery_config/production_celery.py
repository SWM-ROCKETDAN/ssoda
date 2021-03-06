from __future__ import absolute_import
from celery import Celery
import os

# set the default Django settings module for the 'celery_config' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.production')
app = Celery('production_celery')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')