from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.


class User(AbstractUser):
    upvote_list = models.TextField(blank=True, null=True)
    downvote_list = models.TextField(blank=True, null=True)


class Problem(models.Model):
    description = models.TextField(null=True, blank=False)
    category = models.CharField(max_length=50, null=True, blank=True)
    location = models.TextField(null=True, blank=False)
    upvote_count = models.IntegerField(null=False, blank=True, default=0)
    downvote_count = models.IntegerField(null=False, blank=True, default=0)
    severity = models.IntegerField(null=False, blank=True, default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True)
    picture_url = models.URLField(
        null=False,
        blank=True,
        default="https://i1.wp.com/leanprojectplaybook.com/wp-content/uploads/2017/07/Problem-Solution-Fit-64922822_xxl-Puzzle-Piece-e1499237044963.jpg?resize=1030%2C438",
    )
