import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:meta/meta.dart';
import 'screens/event_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static List<Widget> 
  _pages = [  HomePage(),
              MapPage(),
              EventsPage(),
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
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        unselectedFontSize: 10.0,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: ('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: ('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ('Profile'),
          ),
        ],
      ),
    );
  }
}
