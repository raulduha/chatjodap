import 'package:flutter/material.dart';

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
          Center(child: Text('Tu circulo')),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  style: TextStyle(
                    color: Color.fromRGBO(28, 27, 27, 1),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Color.fromRGBO(28, 27, 27, 1)),
                    hintText: 'Buscar usuarios',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(28, 27, 27, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('Buscar usuarios'),
                ),
              ),
            ],
          ),
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
