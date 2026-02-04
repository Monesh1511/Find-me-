from flask import jsonify

def success(data=None, message='OK'):
    payload = {'message': message}
    if data is not None:
        payload['data'] = data
    return jsonify(payload)

def error(message='Error', code=400):
    return jsonify({'error': message}), code
