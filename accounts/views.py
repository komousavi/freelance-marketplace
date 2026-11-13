from rest_framework.views import APIView
from django.db import connection
from accounts.password_hash import verify_password


class LoginView(APIView):

    def login(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
    
    def authenticate(self, username_or_email, password):
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT user_id, username, email, password_hash
                FROM users
                WHERE username = %s OR email = %s #جلوگیری از حمله اینجکشن
                """,
        """ وقتی مقادیر رو در دستورات دیتابیس ننویسیم و جداگانه وارد کنیم:
                دیتابیس دیگه این مقادیر رو به عنوان دستور نمیبینه
                پس اگر یه ورودی مخرب وارد بشه مشکلی پیش نمیاد.
        """
                [username_or_email, username_or_email]
            )

            user = cursor.fetchone()

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