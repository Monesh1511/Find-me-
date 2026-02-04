from werkzeug.security import generate_password_hash, check_password_hash

def hash_password(password: str) -> str:
    """Hash a password using Werkzeug's secure method"""
    return generate_password_hash(password, method='pbkdf2:sha256')

def verify_password(password: str, hashed: str) -> bool:
    """Verify a password against its hash"""
    try:
        return check_password_hash(hashed, password)
    except Exception as e:
        print(f'Error verifying password: {e}')
        return False
