# Generated by Django 3.2.5 on 2021-07-28 00:37

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_alter_eventrewards_rewards'),
    ]

    operations = [
        migrations.AlterField(
            model_name='eventrewards',
            name='rewards',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='event_id', to='api.reward'),
        ),
    ]