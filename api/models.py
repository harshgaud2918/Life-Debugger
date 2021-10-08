from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

class User(AbstractUser):
    upvote_list = models.TextField(blank=True,null=True)
    downvote_list = models.TextField(blank=True,null=True)

    def save(self):
        user = super(User, self)
        user.set_password(self.password)
        user.save()
        return user