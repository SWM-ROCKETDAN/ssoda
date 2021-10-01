# Generated by Django 3.2.5 on 2021-09-24 22:32

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0016_delete_eventrewards'),
    ]

    operations = [
        migrations.AlterField(
            model_name='event',
            name='store',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='core.store'),
        ),
        migrations.AlterField(
            model_name='hashtagrequirements',
            name='hashtag',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.hashtag'),
        ),
        migrations.AlterField(
            model_name='joinpost',
            name='event',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='event', to='core.event'),
        ),
        migrations.AlterField(
            model_name='joinpost',
            name='reward',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='reward', to='core.reward'),
        ),
        migrations.AlterField(
            model_name='reward',
            name='event',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='rewards', to='core.event'),
        ),
        migrations.AlterField(
            model_name='store',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='core.user'),
        ),
        migrations.AlterField(
            model_name='storeimages',
            name='store',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.store'),
        ),
    ]