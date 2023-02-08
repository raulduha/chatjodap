import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_nav_bar.dart';
import 'package:flutter_application_1/screens/forgot_pw_page.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/loginScreen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/registrationScreen.dart';
import 'screens/event_screen.dart';
import 'screens/home_page.dart';



class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = HomePage();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
        
      case '/home':
        page = HomePage();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
      case '/map':
        page = MapPage();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
      case '/events':
        page = EventsPage();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
      case '/profile':
        page = ProfileScreen();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
      case '/register':
        page = RegistrationScreen();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
        ));
      case '/login':
        page = LoginScreen();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
        ));
      default:
        page = HomePage();
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: page,
          bottomNavigationBar: BottomNavBar(),
        ));
    }

  }
}

