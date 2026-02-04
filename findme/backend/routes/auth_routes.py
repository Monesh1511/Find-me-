from flask import Blueprint, request, jsonify
from database.connection import db
from models.user import User
from services.auth_service import AuthService
import traceback

auth_bp = Blueprint('auth', __name__)
service = AuthService()

@auth_bp.route('/register', methods=['POST'])
def register():
    try:
        data = request.get_json() or {}
        name = data.get('name')
        email = data.get('email')
        password = data.get('password')

        if not name or not email or not password:
            return jsonify({'error': 'Missing fields'}), 400

        user = service.register(name=name, email=email, password=password)
        from flask_jwt_extended import create_access_token
        token = create_access_token(identity=user.id)
        print(f'User registered successfully: {user.email} (id={user.id})')
        return jsonify({'user': user.to_dict(), 'token': token}), 201
    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        print(f'Register error: {e}')
        traceback.print_exc()
        return jsonify({'error': 'Internal server error'}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    try:
        print(f'Login request received: {request.json}')
        data = request.get_json() or {}
        email = data.get('email')
        password = data.get('password')

        print(f'Login attempt: email={email}')

        if not email or not password:
            return jsonify({'error': 'Missing fields'}), 400

        token, user = service.login(email=email, password=password)
        if not token or not user:
            print(f'Login failed: invalid credentials for {email}')
            return jsonify({'error': 'Invalid credentials'}), 401

        print(f'Login successful for {email}')
        return jsonify({'token': token, 'user': user.to_dict()}), 200
    except Exception as e:
        print(f'Login error: {e}')
        traceback.print_exc()
        return jsonify({'error': 'Internal server error'}), 500

