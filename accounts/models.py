
from django.db import models


class User(models.Model):
    user_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50, unique=True)
    email = models.CharField(max_length=255, unique=True)
    phonenumber = models.CharField(max_length=20, null=True, blank=True)
    password_hash = models.CharField(max_length=255)
    created_at = models.DateTimeField()
    account_status = models.CharField(max_length=20)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    last_updated_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'users'
        managed = False


class Role(models.Model):
    role_id = models.AutoField(primary_key=True)
    role_name = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'roles'
        managed = False


class UserRole(models.Model):
    pk = models.CompositePrimaryKey('user_id', 'role_id')

    user = models.ForeignKey(
        User,
        on_delete=models.DO_NOTHING,
        db_column='user_id'
    )

    role = models.ForeignKey(
        Role,
        on_delete=models.DO_NOTHING,
        db_column='role_id'
    )

    class Meta:
        db_table = 'user_roles'
        managed = False


class Admin(models.Model):
    admin_id = models.AutoField(primary_key=True)

    user = models.OneToOneField(
        User,
        on_delete=models.DO_NOTHING,
        db_column='user_id'
    )

    granted_at = models.DateTimeField()

    class Meta:
        db_table = 'admins'
        managed = False


class ClientProfile(models.Model):
    client_id = models.AutoField(primary_key=True)

    user = models.OneToOneField(
        User,
        on_delete=models.DO_NOTHING,
        db_column='user_id'
    )

    company_name = models.CharField(
        max_length=255,
        null=True,
        blank=True
    )

    description = models.TextField(
        null=True,
        blank=True
    )

    class Meta:
        db_table = 'client_profile'
        managed = False


class FreelancerProfile(models.Model):
    freelancer_id = models.AutoField(primary_key=True)

    user = models.OneToOneField(
        User,
        on_delete=models.DO_NOTHING,
        db_column='user_id'
    )

    certificates = models.TextField(null=True, blank=True)
    bio = models.TextField(null=True, blank=True)
    location = models.CharField(max_length=255, null=True, blank=True)
    education = models.TextField(null=True, blank=True)
    headline = models.CharField(max_length=255, null=True, blank=True)

    class Meta:
        db_table = 'freelancer_profile'
        managed = False
