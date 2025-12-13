from django.shortcuts import render
from django.http import HttpResponse

def test_page(request):
    print("Test page accessed")
    print(request)
    return HttpResponse("<p>This is a test page.</p>")
# Create your views here.
