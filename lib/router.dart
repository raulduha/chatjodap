import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_nav_bar.dart';
import 'package:flutter_application_1/screens/forgot_pw_page.dart';
import 'package:flutter_application_1/profile_pages/favorites.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/loginScreen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/registrationScreen.dart';
import 'screens/event_screen.dart';
import 'screens/home_page.dart';



import 'package:flutter/material.dart';



class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = BottomNavBar();
        break;
      case '/home':
        page = BottomNavBar();
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
      case '/login':
        page = LoginScreen();
        break;
      case '/register':
        page = RegistrationScreen();
        break;
      default:
        page = BottomNavBar();
        break;
    }
    return MaterialPageRoute(builder: (context) => page);
  }
}
