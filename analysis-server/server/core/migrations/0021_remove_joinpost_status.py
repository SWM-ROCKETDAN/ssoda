# Generated by Django 3.2.5 on 2021-09-27 21:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0020_auto_20210927_2125'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='joinpost',
            name='status',
        ),
    ]
