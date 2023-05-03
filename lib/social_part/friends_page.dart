import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'profile_page.dart';




class FriendsPage extends StatefulWidget {
  final String? currentUserID;

  FriendsPage({this.currentUserID});

  @override
  _FriendsPageState createState() => _FriendsPageState();
}
class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users');
  final DatabaseReference _friendReqRef = FirebaseDatabase.instance.reference().child('friend_requests');
  final DatabaseReference _friendsRef = FirebaseDatabase.instance.reference().child('friends');

  List<dynamic> _searchResults = [];
  List<dynamic> _friendRequests = [];
  List<dynamic> _friends = [];

  @override
  void initState() {
    super.initState();
    _searchResults = [];
    _friendRequests = [];
    _friends = [];

    _friendReqRef.child(widget.currentUserID ?? '').onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _friendRequests = event.snapshot.value as List<dynamic>;
        });
      }
    });

    _friendsRef.child(widget.currentUserID ?? '').onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _friends = event.snapshot.value as List<dynamic>;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchForUser(String query) {
    _userRef.orderByChild('username').startAt(query).endAt(query + '\uf8ff').once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
        setState(() {
          _searchResults = values!.values.toList();
        });
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  void _sendFriendRequest(String? friendID) {
  if (friendID != null) {
    _friendReqRef.child(friendID).push().set(widget.currentUserID!);
  }
}


  void _acceptFriendRequest(String friendID, String requestId) {
    _friendsRef.child(widget.currentUserID!).push().set(friendID);
    _friendsRef.child(friendID).push().set(widget.currentUserID);

    _friendReqRef.child(widget.currentUserID!).child(requestId).remove();
  }

  void _declineFriendRequest(String friendID, String requestId) {
    _friendReqRef.child(widget.currentUserID!).child(requestId).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for friends',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchForUser(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(child: Text('No results found.'))
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      var user = _searchResults[index];
                      bool isFriend = _friends.contains(user['id']);
                      bool hasSentRequest = _friendRequests.any((element) => element['id'] == user['id']);
                      bool hasReceivedRequest = _friendRequests
                      != null && _friendRequests.any((element) => element['id'] == user['id']);
                                        return ListTile(
                    leading: CircleAvatar(
                      //backgroundImage: NetworkImage(user['profileImageUrl']),
                    ),
                    title: Text(user['username']),
                    trailing: hasReceivedRequest
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _acceptFriendRequest(user['id'], _friendRequests
                                      .firstWhere((element) => element['id'] == user['id'])['requestId']);
                                },
                                icon: Icon(Icons.check),
                                color: Colors.green,
                              ),
                              IconButton(
                                onPressed: () {
                                  _declineFriendRequest(user['id'], _friendRequests
                                      .firstWhere((element) => element['id'] == user['id'])['requestId']);
                                },
                                icon: Icon(Icons.close),
                                color: Colors.red,
                              ),
                            ],
                          )
                        : hasSentRequest
                            ? Text('Request Sent')
                            : isFriend
                                ? Text('Friends')
                                : ElevatedButton(
                                    onPressed: () {
                                      _sendFriendRequest(user['id']);
                                    },
                                    child: Text('Add Friend'),
                                  ),
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(
        userID: user['id'],
        isFriend: user['isFriend'] ?? false,
      ),
    ),
  );
},

                  );
                },
              ),
      ),
    ],
  ),
);
  }}
