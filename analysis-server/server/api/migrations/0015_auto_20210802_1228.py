# Generated by Django 3.2.5 on 2021-08-02 12:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0014_auto_20210802_1224'),
    ]

    operations = [
        migrations.AddField(
            model_name='joinpost',
            name='delete_data',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='joinpost',
            name='event',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='api.event'),
        ),
    ]