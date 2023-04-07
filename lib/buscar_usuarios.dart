import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user_model.dart';

class BuscarUsuarios extends StatefulWidget {
  @override
  _BuscarUsuariosState createState() => _BuscarUsuariosState();
}

class _BuscarUsuariosState extends State<BuscarUsuarios> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<UserModel> _users = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    // Fetch user data from Firebase Realtime Database
    databaseReference.child('users').onValue.listen((event) {
      var snapshot = event.snapshot;
      var values = snapshot.value;
      if (values != null) {
        _users.clear(); // Clear the list before adding new users
        (event.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
          if (value != null) { // Check if value is not null before parsing user model
            var user = UserModel.fromJson(Map<String, dynamic>.from(value));

            user.id = key;
            _users.add(user);
          }
        });
        setState(() {});
      }
    });
  }
  @override
Widget build(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
        child: ListView.builder(
          itemCount: _searchQuery.isEmpty
              ? _users.length
              : _users
                  .where((user) =>
                      user.username
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                  .length,
          itemBuilder: (context, index) {
            final user = _searchQuery.isEmpty
                ? _users[index]
                : _users
                    .where((user) =>
                        user.username
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                    .elementAt(index);
            return Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 27, 27, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
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
                        trailing: IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            final currentUserId = 'id_of_current_user'; // add current user id here
                            if (!user.friends.contains(currentUserId)) {
                              user.friends.add(currentUserId);
                              databaseReference
                                  .child('users')
                                  .child(user.id)
                                  .child('friends')
                                  .set(user.friends);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Usuario agregado'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
}