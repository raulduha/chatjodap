
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/alert_dialog.dart';
import 'screens/event_screen.dart';
import 'event_getter.dart';
import 'package:url_launcher/url_launcher.dart';


class EventDetailPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final Event event;

  EventDetailPage({Key? key, required this.event}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Text(event.name),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Name:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                event.name,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Date and Time:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                '${event.date} ${event.time}',
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Description:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                event.description,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Type:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                event.type,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Address:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                event.address,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Promotora:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                event.promotora,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Link de compra:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(

                onTap: () {
                  launchUrl(Uri.parse(event.buyLink));
                  Future.delayed(Duration(seconds: 4), () async {
                    final action = await AlertDialogsInteractive.yesCancelDialog(context, 'Responder', 'Compraste Entrada?', 'No', 'Si', Colors.green);
                    if (action == DialogsAction.yes) {
                      _addHistory();
                    }
                  });
                },

                child: InkWell(
                  child: Text(
                    event.buyLink,
                    style: const 
                      TextStyle(color: Colors.blue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
              ),
              
            )
          ]
        )
      )
    );
  }









  void _addHistory () async {
    
    try {

      Map<String, dynamic> eventData = {
        "name": event.name,
        "date": event.date,
        "time": event.time,
        "address": event.address,
        "latitude": event.lati,
        "longitude": event.longi,
        "type": event.type,
        "description": event.description,
        "promotora": event.promotora,
        "promocionar": event.promocionar,
        "buylink": event.buyLink,
      };
      print("EVENTDATA");
      print(eventData);
      // get the event ID
      print("");
      
      var eventid;

      DatabaseReference eventsRef = FirebaseDatabase.instance.ref().child("events");
      eventsRef.onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> events = snapshot.value as Map<dynamic, dynamic>;
        for (String eventID in events.keys) {
          Map<dynamic, dynamic> eventDataMap = events[eventID];
          print(eventDataMap);
          print(eventID);
          print(events[eventID]["name"]);
          print(eventData["name"]);
          if (events[eventID]["name"] == eventData["name"] && 
            events[eventID]["date"] == eventData["date"] &&
            events[eventID]["promotora"] == eventData["promotora"] &&
            events[eventID]["promocionar"] == eventData["promocionar"])
            {
              print("Coincidencia!");
              print("The event ID is: $eventID");
              eventid = eventID;
              break;
            }
        }
      });



      User? user = _auth.currentUser;
      final userSnapshot =  _database.ref().child("users").child(user!.uid);
      final userHistory = await userSnapshot.child("history").once();

      if (userHistory.snapshot.value != null) {
        print("VALIDO");
        print(userHistory.snapshot.value);

        userSnapshot.child("history").push().set(eventid);
        
      }

      else {

        print("NO HAY NODO HISTORY");
        userSnapshot.child("history").push().set(eventid);
        final userHistory = await userSnapshot.child("history").once();
        print(userHistory.snapshot.value);

        
      }



    } catch (e) {
      print(e);
      
    }
  }




}











