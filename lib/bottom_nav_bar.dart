import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:meta/meta.dart';
import 'screens/event_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/map');
        break;
      case 2:
        Navigator.pushNamed(context, '/events');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      
      selectedLabelStyle: TextStyle(color: Colors.grey),
      unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      
    );
  }
}
