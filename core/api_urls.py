# core/api_urls.py
from django.urls import path
from .api_views import TavoloRigheCreate

urlpatterns = [
    path("tavoli/<int:tavolo_id>/righe", TavoloRigheCreate.as_view(), name="api_tavolo_righe_create"),
]
