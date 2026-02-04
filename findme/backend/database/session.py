from database.connection import db

def commit_session():
    try:
        db.session.commit()
    except Exception:
        db.session.rollback()
        raise

def rollback_session():
    db.session.rollback()
