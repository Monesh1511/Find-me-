Find Me - Flask Backend

Quick start:

1. Create a virtualenv and install requirements:

```bash
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
pip install -r requirements.txt
```

2. Configure environment variables in `.env` (optional). Example:

```
SECRET_KEY=change_me
JWT_SECRET_KEY=change_me
DATABASE_URI=mysql+pymysql://user:pass@localhost/find_me_db
```

3. Initialize the database (use Flask shell or a migration tool like Alembic).

4. Run the app:

```bash
python app.py
```

APIs:
- POST /api/auth/register
- POST /api/auth/login
- POST /api/items
- GET  /api/items/lost
- GET  /api/items/found
- GET  /api/items/<id>
