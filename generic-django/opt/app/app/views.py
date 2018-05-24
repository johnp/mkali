from django.shortcuts import render
from django.contrib.auth.models import User
from django.shortcuts import get_object_or_404

def index(request):
	return render(request, 'app/index.html');

def show_user(request, id):
	user = get_object_or_404(User, pk=id);
	return render(request, 'app/user.html', {'user': user});
