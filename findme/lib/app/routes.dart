import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/items/lost_items_screen.dart';
import '../features/items/found_items_screen.dart';
import '../features/items/add_item_screen.dart';
import '../features/items/item_detail_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const lostItems = '/lost-items';
  static const foundItems = '/found-items';
  static const addItem = '/add-item';
  static const itemDetail = '/item-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case lostItems:
        return MaterialPageRoute(builder: (_) => const LostItemsScreen());
      case foundItems:
        return MaterialPageRoute(builder: (_) => const FoundItemsScreen());
      case addItem:
        return MaterialPageRoute(builder: (_) => const AddItemScreen());
      case itemDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ItemDetailScreen(item: args?['item']),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
