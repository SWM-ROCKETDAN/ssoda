# Generated by Django 3.2.5 on 2021-09-27 21:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0018_alter_taskjoinpost_join_post'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joinpost',
            name='event',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='event', to='core.event'),
        ),
        migrations.AlterField(
            model_name='joinpost',
            name='reward',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='reward', to='core.reward'),
        ),
        migrations.AlterField(
            model_name='reward',
            name='event',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='rewards', to='core.event'),
        ),
        migrations.DeleteModel(
            name='TaskJoinPost',
        ),
    ]
