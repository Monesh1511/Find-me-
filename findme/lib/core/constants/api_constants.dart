class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://localhost:5000/api';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String lostItemsEndpoint = '/items/lost';
  static const String foundItemsEndpoint = '/items/found';
  static const String addItemEndpoint = '/items/add';
  static const String itemDetailEndpoint = '/items';

  // Timeout
  static const Duration timeout = Duration(seconds: 30);

  // Categories
  static const List<String> itemCategories = [
    'Books',
    'Electronics',
    'Clothing',
    'Accessories',
    'Documents',
    'Wallet/Money',
    'Keys',
    'Phone',
    'Bag/Backpack',
    'Watch',
    'Glasses',
    'Other',
  ];

  // Campus Locations
  static const List<String> campusLocations = [
    'Main Building',
    'Library',
    'Student Center',
    'Cafeteria',
    'Sports Complex',
    'Parking Lot',
    'Dormitory',
    'Lab Building',
    'Engineering Block',
    'Other',
  ];
}
