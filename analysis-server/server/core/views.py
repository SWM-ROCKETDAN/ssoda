from rest_framework.views import APIView
from django.http import JsonResponse
from .models import JoinPost

# Report GET 요청
class TestView(APIView):
    def get(self, request, pk):
        tmp = JoinPost.objects.all()
        return JsonResponse({'hello': 'hello'})