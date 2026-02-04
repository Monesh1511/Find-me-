class BaseConfig:
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'find_me_secret_key'
    JWT_SECRET_KEY = 'find_me_jwt_secret'
