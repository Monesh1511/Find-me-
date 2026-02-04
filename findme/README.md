# Find Me - Lost and Found Application

A Flutter mobile app with a Flask backend for finding lost items and posting found items on campus.

## Features

- **User Authentication** - Register and login with email/password
- **Post Items** - Report lost or found items with details
- **Browse Items** - View all lost and found items
- **Item Details** - See complete information about each item
- **Real-time Updates** - View items from other users immediately

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0 or higher) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Python 3.8+** - [Install Python](https://www.python.org/downloads/)
- **Git** - [Install Git](https://git-scm.com/)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Monesh1511/Find-me-.git
cd findme
```

### 2. Frontend Setup (Flutter)

```bash
# Get Flutter dependencies
flutter pub get

# Run the app on web
flutter run -d web

# Or run on Android/iOS
flutter run
```

### 3. Backend Setup (Flask)

```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python -m venv .venv

# Activate virtual environment
# On Windows:
.venv\Scripts\activate

# On macOS/Linux:
source .venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Run the Flask server
python app.py
```

The Flask server will start on `http://localhost:5000`

## Project Structure

```
findme/
├── lib/                    # Flutter app source code
│   ├── app/               # App configuration and routes
│   ├── features/          # Feature screens (auth, items, home)
│   ├── services/          # API and auth services
│   ├── models/            # Data models
│   ├── widgets/           # Reusable UI components
│   └── core/              # Constants, themes, utilities
├── backend/               # Flask REST API
│   ├── app.py            # Main application
│   ├── config/           # Configuration files
│   ├── models/           # Database models
│   ├── routes/           # API endpoints
│   ├── services/         # Business logic
│   ├── database/         # Database connection
│   ├── utils/            # Utility functions
│   └── requirements.txt   # Python dependencies
└── README.md
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Items
- `GET /api/items/lost` - Get all lost items
- `GET /api/items/found` - Get all found items
- `POST /api/items` - Create new item
- `GET /api/items/<id>` - Get item details

## Configuration

### Frontend API Base URL
Edit `lib/core/constants/api_constants.dart` to change the API endpoint:

```dart
const String API_BASE_URL = 'http://localhost:5000/api';
```

### Backend Database
The app uses SQLite by default. Database file is created at `backend/instance/find_me.db`

## Running the Application

### Development Mode

**Terminal 1 - Run Backend:**
```bash
cd backend
python app.py
```

**Terminal 2 - Run Frontend:**
```bash
flutter run -d web
```

The app will open in your browser at `http://localhost:52682` (or similar port)

## Technologies Used

- **Frontend**: Flutter, Dart
- **Backend**: Flask, Python
- **Database**: SQLite
- **Authentication**: JWT Tokens
- **HTTP Client**: http (Flutter)

## Troubleshooting

### Backend connection refused error
- Ensure Flask server is running on `http://localhost:5000`
- Check firewall settings

### Module not found errors
- Reinstall Python dependencies: `pip install -r requirements.txt`

### Flutter dependency issues
- Run: `flutter clean && flutter pub get`

## Future Enhancements

- Image upload for items
- Location-based search
- Email notifications
- In-app messaging between users
- Admin dashboard

## License

This project is open source and available under the MIT License.

## Support

For issues or questions, please create an issue on [GitHub](https://github.com/Monesh1511/Find-me-/issues).
