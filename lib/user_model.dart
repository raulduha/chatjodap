import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String id;
  final String name;
  final String username;
  final String lastname;
  final String email;
  List<String> friends; // add this property
  
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.lastname,
    required this.email,
    required this.friends,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      friends: json['friends'] != null
          ? List<String>.from(json['friends'])
          : [], // parse the friends array

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'lastname': lastname,
      'email': email,
      'friends': friends, // include the friends array in the JSON representation
  
    };
  }
  void addFriend(String friendId) {
    if (!friends.contains(friendId)) {
      friends.add(friendId);
      FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(id)
          .update({'friends': friends});
    }
  }
}
