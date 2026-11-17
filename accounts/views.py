
from hashlib import sha256

from django.db import connection, transaction, IntegrityError
from django.core.cache import cache
from django.utils import timezone

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from accounts.models import (
    User,
    Role,
    ClientProfile,
    FreelancerProfile,
)

from accounts.serializers import RegisterSerializer
from accounts.password_hash import hash_password, verify_password


class RegisterView(APIView):

    def post(self, request):

        serializer = RegisterSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST
            )

        data = serializer.validated_data

        try:
            with transaction.atomic():

                # Check username and email uniqueness
                if User.objects.filter(username__iexact=data["username"]).exists():
                    return Response(
                        {"username": "This username is already taken."},
                        status=status.HTTP_409_CONFLICT
                    )

                if User.objects.filter(email__iexact=data["email"]).exists():
                    return Response(
                        {"email": "This email is already registered."},
                        status=status.HTTP_409_CONFLICT
                    )

                # Find the requested role
                try:
                    role = Role.objects.get(
                        role_name__iexact=data["role"]
                    )
                except Role.DoesNotExist:
                    return Response(
                        {"role": "Selected role does not exist in the database."},
                        status=status.HTTP_400_BAD_REQUEST
                    )

                # Hash password
                password_hash = hash_password(data["password"])

                # Create user
                user = User.objects.create(
                    username=data["username"],
                    email=data["email"],
                    phonenumber=data["phonenumber"],
                    password_hash=password_hash,
                    first_name=data["first_name"],
                    last_name=data["last_name"],
                    created_at=timezone.now(),
                    account_status="Active",
                    last_updated_at=timezone.now()
                )

                # Assign role to user
                with connection.cursor() as cursor:
                    cursor.execute(
                        """
                        INSERT INTO user_roles (user_id, role_id)
                        VALUES (%s, %s)
                        """,
                        [user.user_id, role.role_id]
                    )

                # Create an empty profile based on the role
                if data["role"] == "client":
                    ClientProfile.objects.create(user=user)

                elif data["role"] == "freelancer":
                    FreelancerProfile.objects.create(user=user)

                return Response(
                    {
                        "detail": "Registration successful.",
                        "user": {
                            "user_id": user.user_id,
                            "username": user.username,
                            "email": user.email,
                            "role": role.role_name
                        }
                    },
                    status=status.HTTP_201_CREATED
                )

        except IntegrityError:
            return Response(
                {
                    "detail": "Username or email already exists."
                },
                status=status.HTTP_409_CONFLICT
            )


class LoginView(APIView):

    def post(self, request):
        return self.login(request)


    def login(self, request):

        username = request.data.get("username")
        password = request.data.get("password")

        if not username or not password:
            return Response(
                {"detail": "Username and password are required."},
                status=status.HTTP_400_BAD_REQUEST
            )

        user = self.get_user(username)

        if user is not None:
            cache_identity = f"user:{user[0]}"
        else:
            normalized_identity = username.strip().lower()

            identity_hash = sha256(
                normalized_identity.encode()
            ).hexdigest()

            cache_identity = f"unknown:{identity_hash}"

        attempts_key = f"login_attempts:{cache_identity}"
        lock_key = f"login_lock:{cache_identity}"

        if cache.get(lock_key):
            return Response(
                {
                    "detail": "Too many failed attempts. Try again in 5 minutes."
                },
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
                    {
                        "detail": "Too many failed attempts. Try again in 5 minutes."
                    },
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


    def get_user(self, username):

        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT user_id, username, email, password_hash
                FROM users
                WHERE username = %s
                """,
                [username]
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
