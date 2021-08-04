# Generated by Django 3.2.5 on 2021-08-02 12:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_remove_joinpost_delete_date'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('email', models.CharField(max_length=255)),
                ('name', models.CharField(max_length=255)),
                ('picture', models.CharField(blank=True, max_length=255, null=True)),
                ('role', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'user',
                'managed': False,
            },
        ),
        migrations.AlterModelOptions(
            name='event',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='eventimages',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='eventrewards',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtag',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtaghashtags',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtagrequirements',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='joinpost',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='joinuser',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='reward',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='store',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='storeimages',
            options={'managed': False},
        ),
    ]