import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userID;
  final bool isFriend;

  const ProfilePage({required this.userID, this.isFriend = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User ID: $userID',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            isFriend == true
                ? Text(
                    'You are friends!',
                    style: TextStyle(fontSize: 18),
                  )
                : isFriend == false
                    ? Text(
                        'You are not friends yet.',
                        style: TextStyle(fontSize: 18),
                      )
                    : Text(
                        'Friendship status unknown.',
                        style: TextStyle(fontSize: 18),
                      ),
          ],
        ),
      ),
    );
  }
}
