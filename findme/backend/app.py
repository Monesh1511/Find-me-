from flask import Flask
from config.dev_config import DevConfig
from database.connection import db, init_db
from routes.auth_routes import auth_bp
from routes.item_routes import item_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(DevConfig)

    init_db(app)

    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(item_bp, url_prefix='/api/items')

    @app.route('/')
    def index():
        return {'message': 'Find Me API'}, 200

    with app.app_context():
        db.create_all()

    return app

if __name__ == '__main__':
    app = create_app()
    print('Flask app running on http://localhost:5000')
    print('Endpoints:')
    print('  POST /api/auth/register')
    print('  POST /api/auth/login')
    print('  POST /api/items')
    print('  GET  /api/items/lost')
    print('  GET  /api/items/found')
    print('  GET  /api/items/<id>')
    app.run(debug=False, host='0.0.0.0', port=5000)
