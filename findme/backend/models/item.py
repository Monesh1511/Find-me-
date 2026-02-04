from database.connection import db
from datetime import datetime

class Item(db.Model):
    __tablename__ = 'items'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    category = db.Column(db.String(50))
    location = db.Column(db.String(100))
    contact = db.Column(db.String(100))
    status = db.Column(db.Enum('lost', 'found', name='status_enum'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'category': self.category,
            'location': self.location,
            'contact': self.contact,
            'status': self.status,
            'user_id': self.user_id,
            'created_at': self.created_at.isoformat(),
        }
