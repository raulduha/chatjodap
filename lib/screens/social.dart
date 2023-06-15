import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_application_1/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/social_part/mi_circulo.dart';
import 'package:flutter_application_1/social_part/search_users.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 36, 39, 1),
      appBar: AppBar(
        title: Container(
  height: 50,
  color: const Color.fromRGBO(36, 36, 39, 1),
  padding: const EdgeInsets.only(left: 16),
  child: Row(
    children: [
      Text(
        'SOCIAL',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF993A84),
        ),
      ),
    ],
  ),
        ),
        backgroundColor: Color.fromRGBO(36, 36, 39, 1),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tu circulo'),
            Tab(text: 'Buscar usuarios'),
          ],
          indicatorColor: Color(0xFF993A84),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MiCirculo(),
          SearchUsersPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
