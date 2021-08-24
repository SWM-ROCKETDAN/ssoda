# Generated by Django 3.2.5 on 2021-08-06 14:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0020_rename_delete_data_joinpost_delete_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='reward',
            name='event',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='api.event'),
        ),
        migrations.AddField(
            model_name='reward',
            name='level',
            field=models.BigIntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='reward',
            name='used_count',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]