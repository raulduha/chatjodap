import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_application_1/user_model.dart';


class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final databaseReference = FirebaseDatabase.instance.reference();
  List<UserModel> _users = [];
  String _searchQuery = '';
@override
void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);

  // Fetch user data from Firebase Realtime Database
  databaseReference.child('users').onValue.listen((event) {
    var snapshot = event.snapshot;
    var values = snapshot.value;
    if (values != null) {
      _users.clear(); // Clear the list before adding new users
      (event.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      var user = UserModel.fromJson(Map<String, dynamic>.from(value));


      user.id = key;
      _users.add(user);
});
      setState(() {});
    }
  });
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: TextField(
                  style: TextStyle(
                    color: Color.fromRGBO(28, 27, 27, 1),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                        Icon(Icons.search, color: Color.fromRGBO(28, 27, 27, 1)),
                    hintText: 'Buscar usuarios',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(28, 27, 27, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
  child:ListView.builder(
  itemCount: _searchQuery.isEmpty
      ? _users.length
      : _users
          .where((user) =>
              user.username.toLowerCase().contains(_searchQuery.toLowerCase()))
          .length,
  itemBuilder: (context, index) {
    final user = _searchQuery.isEmpty
        ? _users[index]
        : _users
            .where((user) =>
                user.username.toLowerCase().contains(_searchQuery.toLowerCase()))
            .elementAt(index);
    return ListTile(
      leading: Image.asset(
        'images/empty_profile.png',
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
      title: Text(
        user.username,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        user.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  },
)


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