# Generated by Django 3.2.5 on 2021-09-27 21:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0022_joinpost_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='hashtaghashtags',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
    ]
