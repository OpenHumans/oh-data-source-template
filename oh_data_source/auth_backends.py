from django.contrib.auth.backends import ModelBackend


class AuthenticationBackend(ModelBackend):
    """
    Can be used for login using Open Humans OAuth2 as user credentials.
    """

    def authenticate(self, **credentials):
        return None
