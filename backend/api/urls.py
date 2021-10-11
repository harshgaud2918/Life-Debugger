from django.urls import path
from django.urls.resolvers import URLPattern
from . import views

urlpatterns = [
    path("problems", views.api_problem),
    path("update/<int:id>", views.api_problem_update),
    path("delete/<int:id>", views.api_problem_delete)
]
