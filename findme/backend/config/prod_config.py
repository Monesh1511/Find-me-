from .base_config import BaseConfig
import os

class ProdConfig(BaseConfig):
    base_dir = os.path.abspath(os.path.dirname(__file__))
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(base_dir, '..', 'instance', 'find_me.db')
    DEBUG = False
