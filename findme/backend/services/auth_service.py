from database.connection import db, jwt
from models.user import User
from utils.password_utils import hash_password, verify_password
from flask_jwt_extended import create_access_token

class AuthService:
    def register(self, name, email, password):
        existing = User.query.filter_by(email=email).first()
        if existing:
            raise ValueError('Email already registered')
        hashed = hash_password(password)
        user = User(name=name, email=email, password=hashed)
        db.session.add(user)
        db.session.commit()
        return user

    def login(self, email, password):
        user = User.query.filter_by(email=email).first()
        if not user:
            return None, None
        if not verify_password(password, user.password):
            return None, None
        token = create_access_token(identity=user.id)
        return token, user
