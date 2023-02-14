

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/widgets/historyCard.dart';


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
  bool _getHistoryCalled = false;


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

      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)), // 3 seconds delay
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _events.isEmpty
            ? const Center(
                child: Text("No hay eventos en tu historial aún!",
                  style: TextStyle(color: Colors.white, fontFamily: "Brand Bold", fontSize: 17)
                ),
              )
            : ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];

                  return HistoryCard(
                    eventName: event['name'], 
                    eventLocation: event['address'], 
                    eventDate: event['date'], 
                    eventType: event['type'],
                  );
                  
                },
              );
          }
        },
      ),

    







    );
    
  }





  Future<void> _getHistory() async {
    if (_getHistoryCalled == true) {
      return;
    }
    
    _getHistoryCalled = true;

    setState(() {
      _isLoading = true;
    });

    // await Future.delayed(Duration(seconds: 5));

    try {

      // user data
      User? user = _auth.currentUser;
      final userSnapshot =  _database.ref().child("users").child(user!.uid);
      final userHistory = await userSnapshot.child("history").once();
  
      if (userHistory.snapshot.value != null) {

        print(userHistory.snapshot.value);

        final userHistoryData = userHistory.snapshot.value;
        final userHistoryDataMap = userHistoryData as Map<dynamic, dynamic>;
        final historyEvents = userHistoryDataMap.values.toList();

        for (var element in (historyEvents)) {

          // aca buscar elemento en la bdd
          
          final event = _database.ref().child("events").child(element);
          
          event.once().then((DatabaseEvent databaseEvent) {
            final DataSnapshot snapshot = databaseEvent.snapshot;
            final eventData = snapshot.value;
            print("eventdata:");
            print(eventData);
            
            _events.add(eventData);

            print(_events);
            print(_events.length);
          });


        }

        // ARREGLAR, FUNCIONA A VECES
        _events.sort((a, b) {
          var dateA = DateTime.parse(a['date']);
          var dateB = DateTime.parse(b['date']);
          return dateB.compareTo(dateA);
        });


        setState(() {
          _isLoading = false;
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print("no hay historial disponible");
        
      }
      
      
    } catch (e) {
      print(e);
    }
  }





}
