from django.http.response import JsonResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import *
from django.core import serializers
# Create your views here.
@api_view(['GET'])
def overview(request):
    hg = {
        'problem_id':'69',
        'description':'This is test problem',
        'location':'Indore'

    }
    users = User.objects.all()
    data = serializers.serialize("json",users)
    
    return Response(data)
