
import bcrypt


def hash_password(user_password: str) -> str:
    """
رمز عبور را با استفاده از الگوریتم 
`bcrypt` 
هش می‌کند.
پیشوند هش را از
`$2b$`
به
`$2a$` تغییر می‌دهد
تا با `pgcrypto` در `PostgreSQL` سازگار باشد.
"""

    password_bytes = user_password.encode("utf-8")

    hashed_password = bcrypt.hashpw(
        password_bytes,
        bcrypt.gensalt(rounds=12)
    ).decode("ascii")

    if hashed_password.startswith("$2b$"):
        hashed_password = "$2a$" + hashed_password[4:]
    """
    از اندیس 4 به بعد را برمیدارد. 
    `postgreSQL` قادر به تطبیق هش های ایجاد شده نبود.
    
    """
    return hashed_password


def verify_password(user_password: str, saved_password_hash: str) -> bool:
    """
    بررسی رمز عبور با استفاده از یک هش ذخیره‌شده‌ی `bcrypt`
    """

    password_bytes = user_password.encode("utf-8")
    hash_bytes = saved_password_hash.encode("ascii")

    return bcrypt.checkpw(password_bytes, hash_bytes)