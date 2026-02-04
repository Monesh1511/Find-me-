from flask import Blueprint, request, jsonify
from services.item_service import ItemService

item_bp = Blueprint('items', __name__)
service = ItemService()

@item_bp.route('', methods=['POST'])
def add_item():
    try:
        data = request.get_json() or {}
        print(f'Add item request: {data}')
        if not data:
            return jsonify({'error': 'Request body is empty'}), 400
        item = service.create_item(data)
        print(f'Item created successfully: {item.id}')
        return jsonify({'item': item.to_dict()}), 201
    except ValueError as e:
        print(f'ValueError in add_item: {e}')
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        import traceback
        print(f'Error in add_item: {e}')
        traceback.print_exc()
        return jsonify({'error': 'Internal server error'}), 500

@item_bp.route('/lost', methods=['GET'])
def get_lost_items():
    items = service.get_items_by_status('lost')
    return jsonify({'items': [i.to_dict() for i in items]}), 200

@item_bp.route('/found', methods=['GET'])
def get_found_items():
    items = service.get_items_by_status('found')
    return jsonify({'items': [i.to_dict() for i in items]}), 200

@item_bp.route('/<int:item_id>', methods=['GET'])
def get_item(item_id):
    item = service.get_item_by_id(item_id)
    if not item:
        return jsonify({'error': 'Not found'}), 404
    return jsonify({'item': item.to_dict()}), 200
