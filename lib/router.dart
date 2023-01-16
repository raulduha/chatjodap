import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_nav_bar.dart';
import 'package:flutter_application_1/favorites.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'event_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = HomePage();
        break;
      case '/home':
        page = HomePage();
        break;
      case '/favorite':
        page = FavoritesScreen();
        break;
      case '/events':
        page = EventScreen();
        break;
      case '/profile':
        page = ProfileScreen();
        break;
      default:
        page = HomePage();
    }
    return MaterialPageRoute(builder: (_) => Scaffold(
      body: page,
      
      bottomNavigationBar: BottomNavBar(),
    ));
  }
}

