# Generated by Django 3.2.7 on 2021-10-10 10:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20211009_2354'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='problem',
            name='problem_id',
        ),
        migrations.AddField(
            model_name='problem',
            name='id',
            field=models.BigAutoField(auto_created=True, default=1, primary_key=True, serialize=False, verbose_name='ID'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='problem',
            name='picture_url',
            field=models.URLField(blank=True, default='https://i1.wp.com/leanprojectplaybook.com/wp-content/uploads/2017/07/Problem-Solution-Fit-64922822_xxl-Puzzle-Piece-e1499237044963.jpg?resize=1030%2C438'),
        ),
    ]
