from django.db.models import manager
from django.http.response import JsonResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate, login, logout

from .models import *
from .serializers import *


@api_view(["GET", "POST"])
def api_problem(request):
    # View Problem
    if request.method == "GET":
        problems = Problem.objects.all().order_by('-upvote_count')
        problems = ProblemSerializer(problems, many=True).data
        return Response(problems)
    # Create Problem
    else:
        res = {}
        res["description"] = request.data["description"]
        res["category"] = request.data["category"]
        res["location"] = request.data["location"]
        res["upvote_count"] = request.data["upvote_count"]
        res["downvote_count"] = request.data["downvote_count"]
        res["severity"] = request.data["severity"]
        res["user"] = request.data["user"]
        res["picture_url"] = request.data["picture_url"]
        serializer = ProblemSerializer(data=res)
        if serializer.is_valid():
            serializer.save()
            res = serializer.data
            res["message"] = "Your Problem is created. You will be notified soon."
            return Response(res)
        res = serializer.errors
        res["message"] = "There was a problem while creating the problems"
        return Response(res, status.HTTP_400_BAD_REQUEST)


@api_view(["PUT"])
def api_problem_update(request,id):
    problem = Problem.objects.get(id=id)    
    res={}
    request.data["upvote_count"] += problem.upvote_count
    request.data["downvote_count"] += problem.downvote_count
    serializer=ProblemSerializer(problem,data=request.data)
    if serializer.is_valid():
        serializer.save()
        res["message"]="Your problem is updated"
        return Response(res)
    
    res=serializer.errors
    res["message"]="There was a problem while updating your problem"
    return Response(res, status.HTTP_400_BAD_REQUEST)

    
@api_view(["DELETE"])
def api_problem_delete(request,id):
    try:
        problem = Problem.objects.get(id=id)
    except Problem.DoesNotExist:
        return Response(status.HTTP_404_NOT_FOUND)
    
    operation= problem.delete()
    res={}
    if operation:
        res["message"]="delete successful"
    else:
        res["message"]="Cound not delete your problem"
    
    return Response(res)




@api_view(["POST"])
def api_login(request):
    if request.method == 'POST':
        username = request.data['username']
        password = request.data['password']
        user = authenticate(request, username=username, password=password)
        res ={}
        if user is not None:
            login(request, user)
            c_user = User.objects.get(username=username)
            res = UserSerializer(c_user).data
            return Response(res)            

        else:
            res["message"] = "User Doesn't Exist"
            return Response(res, status.HTTP_400_BAD_REQUEST)

@api_view(["GET"])
def api_all_users(request):
    users = User.objects.all()
    res = UserSerializer(users,many=True).data
    return Response(res)

@api_view(["POST"])
def api_create_user(request):
        res = {}
        res["username"] = request.data["email"]
        res["password"] = request.data["password"]
        res["email"] = request.data["email"]
        res["first_name"] = request.data["name"]
        res["is_active"] = True
        res["is_staff"] = True
        
        serializer = UserSerializer(data=res)
        if serializer.is_valid():
            serializer.save()
            user = User.objects.get(username=request.data["email"])
            user.set_password(request.data["password"])
            user.save()
            res = UserSerializer(user).data
            res["message"] = "User created"
            return Response(res)
        res = serializer.errors
        res["message"] = "There was a problem while creating the problems"
        return Response(res, status.HTTP_400_BAD_REQUEST)

@api_view(["GET"])
def api_city_problem(request,pk):
    problems = Problem.objects.all().order_by('-upvote_count')
    res = []
    for problem in problems:
        loc = problem.location
        if "City" in loc and loc["City"] == pk:
            res.append(problem)
    if len(res)==0:
        res ={}
        res["message"] = "No Problems Found !"
        return Response(res)
    
    data=ProblemSerializer(res, many=True).data
    return Response(data)

@api_view(["GET"])
def api_state_problem(request,pk):
    problems = Problem.objects.all().order_by('-upvote_count')
    res = []
    for problem in problems:
        loc = problem.location
        if "State" in loc and loc["State"] == pk:
            res.append(problem)
    if len(res)==0:
        res ={}
        res["message"] = "No Problems Found !"
        return Response(res)
    data=ProblemSerializer(res, many=True).data
    return Response(data)