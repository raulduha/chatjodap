import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_nav_bar.dart';
import 'package:flutter_application_1/favorites.dart';
import 'package:flutter_application_1/map_screen.dart';
import 'package:flutter_application_1/loginScreen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter_application_1/registrationScreen.dart';
import 'event_screen.dart';
import 'home_page.dart';

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
      case '/map':
        page = MapPage();
        break;
      case '/events':
        page = EventsPage();
        break;
      case '/profile':
        page = ProfileScreen();
        break;
      case '/register':
        page = RegistrationScreen();
        break;
      case '/login':
        page = LoginScreen();
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

