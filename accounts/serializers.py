
from rest_framework import serializers

from accounts.validators import (
    validate_username,
    validate_role,
    validate_password_value,
)


class RegisterSerializer(serializers.Serializer):

    first_name = serializers.CharField(max_length=100)
    last_name = serializers.CharField(max_length=100)

    username = serializers.CharField(
        max_length=50,
        validators=[validate_username]
    )

    email = serializers.EmailField(max_length=255)

    phonenumber = serializers.CharField(max_length=20)

    password = serializers.CharField(
        write_only=True,
        validators=[validate_password_value]
    )

    confirm_password = serializers.CharField(write_only=True)

    role = serializers.CharField(validators=[validate_role])

    def validate(self, attrs):

        if attrs["password"] != attrs["confirm_password"]:
            raise serializers.ValidationError({
                "confirm_password": "Passwords do not match."
            })

        attrs["username"] = attrs["username"].strip()
        attrs["email"] = attrs["email"].strip().lower()
        attrs["phonenumber"] = attrs["phonenumber"].strip()
        attrs["first_name"] = attrs["first_name"].strip()
        attrs["last_name"] = attrs["last_name"].strip()
        attrs["role"] = attrs["role"].strip().lower()

        return attrs
