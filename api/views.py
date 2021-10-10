from django.http.response import JsonResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import *
from .serializers import *


@api_view(["GET"])
def api_problem(request):
    problems = Problem.objects.all()
    problems = ProblemSerializer(problems, many=True).data
    return Response(problems)
