import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  User? _currentUser;
  String? _authToken;

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  User? get currentUser => _currentUser;
  String? get authToken => _authToken;
  bool get isAuthenticated => _currentUser != null && _authToken != null;

  Future<void> login(User user, String token) async {
    _currentUser = user;
    _authToken = token;
    // TODO: Save token to secure storage
  }

  Future<void> logout() async {
    _currentUser = null;
    _authToken = null;
    // TODO: Clear secure storage
  }

  Future<void> register(User user, String token) async {
    _currentUser = user;
    _authToken = token;
    // TODO: Save token to secure storage
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  void setAuthToken(String token) {
    _authToken = token;
  }
}
