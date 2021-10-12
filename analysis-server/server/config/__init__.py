from __future__ import absolute_import, unicode_literals

# This will make sure the app is always imported when
# Django starts so that shared_task will use this app.
# from .celery_config import app as celery_app
from .celery_config.development_celery import app as development_celery_app
from .celery_config.production_celery import app as production_celery_app


__all__ = ('development_celery_app', 'production_celery_app', )