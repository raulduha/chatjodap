import 'dart:ffi';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final List _events = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[200],
        title: const Text(
          "Your Events History",
        ),
        centerTitle: true,
      ),

      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,

      
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : ListView.builder(
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];

              return ListTile(
                isThreeLine: true,
                title: Text(event['name']),
                subtitle: Text(event['date']),
                // subtitle: Text(event['type']),
                  
              );
            },
          ),
          

    );
    
  }








  Future<void> _getHistory() async {
    try {

      // user data
      User? user = _auth.currentUser;
      final userSnapshot =  _database.ref().child("users").child(user!.uid);
      final userHistory = await userSnapshot.child("history").once();
      print(userHistory.snapshot.value);
      final userHistoryData = userHistory.snapshot.value as Map<dynamic, dynamic>;
      
      if (userHistory != null) {
        userHistoryData.forEach((key, value) {
          _events.add(value);
        });
      }
      setState(() {
        _isLoading = false;
      });
      
    } catch (e) {
      print(e);
    }
  }



}
