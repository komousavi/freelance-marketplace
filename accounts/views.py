
from hashlib import sha256

from django.db import connection
from django.core.cache import cache

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from accounts.password_hash import verify_password


class LoginView(APIView):

    def post(self, request):
        return self.login(request)

    def login(self, request):
        username_or_email = request.data.get("username")
        password = request.data.get("password")

        if not username_or_email or not password:
            return Response(
                {"detail": "Username and password are required."},
                status=status.HTTP_400_BAD_REQUEST
            )

        user = self.get_user(username_or_email)

        if user is not None:
            cache_identity = f"user:{user[0]}"
        else:
            normalized_identity = username_or_email.strip().lower()
            identity_hash = sha256(
                normalized_identity.encode()
            ).hexdigest()

            cache_identity = f"unknown:{identity_hash}"

        attempts_key = f"login_attempts:{cache_identity}"
        lock_key = f"login_lock:{cache_identity}"

        if cache.get(lock_key):
            return Response(
                {"detail": "Too many failed attempts. Try again in 5 minutes."},
                status=status.HTTP_429_TOO_MANY_REQUESTS
            )

        authenticated_user = self.authenticate(user, password)

        if authenticated_user is None:

            if not cache.add(attempts_key, 1, timeout=300):
                attempts = cache.incr(attempts_key)
            else:
                attempts = 1

            if attempts >= 5:
                cache.set(lock_key, True, timeout=300)
                cache.delete(attempts_key)

                return Response(
                    {"detail": "Too many failed attempts. Try again in 5 minutes."},
                    status=status.HTTP_429_TOO_MANY_REQUESTS
                )

            return Response(
                {"detail": "Invalid username or password."},
                status=status.HTTP_401_UNAUTHORIZED
            )

        cache.delete(attempts_key)

        return Response(
            authenticated_user,
            status=status.HTTP_200_OK
        )

    def get_user(self, username_or_email):
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT user_id, username, email, password_hash
                FROM users
                WHERE username = %s OR email = %s
                """,
                [username_or_email, username_or_email]
            )

            return cursor.fetchone()

    def authenticate(self, user, password):
        if user is None:
            return None

        user_id, username, email, saved_password_hash = user

        if verify_password(password, saved_password_hash):
            return {
                "user_id": user_id,
                "username": username,
                "email": email
            }

        return None
