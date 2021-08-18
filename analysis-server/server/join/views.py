from rest_framework.views import APIView
from django.http import JsonResponse


# Report GET 요청
class TestView(APIView):
    def get(self, request, pk):
        return JsonResponse({'hello': 'hello'})
