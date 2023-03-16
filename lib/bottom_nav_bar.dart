import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/screens/social.dart';
import 'package:meta/meta.dart';
import 'screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static final List<Widget> 
  _pages = [  HomePage(),
              MapPage(),
              EventsPage(),
              SocialPage(),
              ProfileScreen(),
            ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        unselectedFontSize: 10.0,
        selectedItemColor: Color(0xFF993A84),
        selectedLabelStyle: TextStyle(color: Colors.grey[900]),
        unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.1)),
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: ('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: ('Eventos'),
          ),
          BottomNavigationBarItem(
            icon: Icon( FontAwesomeIcons.users),
            label: ('  Social'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ('Perfil'),
          ),
        ],
      ),
    );
  }
}
