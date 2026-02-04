from database.connection import db
from models.item import Item

class ItemService:
    def create_item(self, data):
        title = data.get('title')
        description = data.get('description')
        category = data.get('category')
        location = data.get('location')
        contact = data.get('contact')
        status = data.get('status')
        user_id = data.get('user_id')

        if not title or not description or not status:
            raise ValueError('Missing required fields')

        item = Item(
            title=title,
            description=description,
            category=category,
            location=location,
            contact=contact,
            status=status,
            user_id=user_id,
        )
        db.session.add(item)
        db.session.commit()
        return item

    def get_items_by_status(self, status):
        return Item.query.filter_by(status=status).order_by(Item.created_at.desc()).all()

    def get_item_by_id(self, item_id):
        return Item.query.get(item_id)
