from django.urls import path
from django.urls.resolvers import URLPattern
from . import views

urlpatterns = [
    path("problems", views.api_problem),
    path("update/<int:id>", views.api_problem_update),
    path("delete/<int:id>", views.api_problem_delete),
    path("login", views.api_login),
    path("users", views.api_all_users),
    path("createuser", views.api_create_user),
    path("problems/city/<str:pk>", views.api_city_problem),
    path("problems/state/<str:pk>", views.api_state_problem),


]
