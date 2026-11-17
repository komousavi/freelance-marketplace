
import re

from django.core.exceptions import ValidationError
from django.contrib.auth.password_validation import validate_password


def validate_username(value):
    """
    Username must contain only English letters and numbers.
    """

    if not re.fullmatch(r"[A-Za-z0-9]+", value):
        raise ValidationError(
            "Username can only contain English letters and numbers."
        )


def validate_role(value):
    """
    User role must be client or freelancer.
    """

    allowed_roles = ["client", "freelancer"]

    if value not in allowed_roles:
        raise ValidationError(
            "Role must be either client or freelancer."
        )


def validate_password_value(value):
    """
    Validate password using Django's password validators.
    """

    try:
        validate_password(value)
    except ValidationError:
        raise


def validate_skills(skills):
    """
    A freelancer can select at most 15 skills.
    """

    if len(skills) > 15:
        raise ValidationError(
            "A freelancer cannot select more than 15 skills."
        )
