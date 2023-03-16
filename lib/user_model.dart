class UserModel {
  String id;
  final String name;
  final String username;
  final String lastname;
  final String email;
  //final String photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.lastname,
    required this.email,
//required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      //photoUrl: json['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'lastname': lastname,
      'email': email,
      //'photoUrl': photoUrl,
    };
  }
}
