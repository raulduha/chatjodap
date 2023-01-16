import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites List'),
      ),
      body: Center(
        child: Text('This is the favorites List Screen'),
      ),
      
    );
  }
}
