from django.http.response import JsonResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from .models import *
from .serializers import *


@api_view(["GET", "POST"])
def api_problem(request):
    # View Problem
    if request.method == "GET":
        problems = Problem.objects.all()
        problems = ProblemSerializer(problems, many=True).data
        return Response(problems)
    # Create Problem
    else:
        res = {}
        res["description"] = request.POST["description"]
        res["category"] = request.POST["category"]
        res["location"] = request.POST["location"]
        res["upvote_count"] = request.POST["upvote_count"]
        res["downvote_count"] = request.POST["downvote_count"]
        res["severity"] = request.POST["severity"]
        res["user"] = request.POST["user"]
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
        res["message"]:"delete successful"
    else:
        res["message"]:"Cound not delete your problem"
    
    return Response(res)

