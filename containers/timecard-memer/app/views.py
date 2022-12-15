#from django.http import HttpResponse
from django.shortcuts import render
from app import image_helper

def index(request):
    meme = image_helper.get_random_meme
    return render(request, "index.html", {'meme': meme})
