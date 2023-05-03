import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_application_1/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/social_part/mi_circulo.dart';
import 'package:flutter_application_1/social_part/friends_page.dart';

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
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        title: Container(
          child: Image.asset('images/social.png'),
          height: 50,
        ),
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
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
          FriendsPage(),
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
