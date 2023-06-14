
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/alert_dialog.dart';

import 'event_getter.dart';
import 'package:url_launcher/url_launcher.dart';


class EventDetailPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final Event event;

  EventDetailPage({Key? key, required this.event}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Text(
          event.name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('images/event_card_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 130,
              margin: EdgeInsets.only(bottom: 10.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
  child: Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '${event.name}.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextSpan(text: '    '),
        TextSpan(
          text: '${event.date}, ${event.time}hrs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
),

                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Descripción:",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Evento de ${event.type}. ${event.description}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    event.address,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promotora:",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    event.promotora,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.0), // Add a height to the bottom to make room for the "comprar aqui" bar
          ],
        ),
      ),
      bottomSheet: GestureDetector(
  onTap: () => _onEntradasTap(context),
  child: Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color.fromRGBO(36, 36, 39, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, -3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Comprar entradas aquí: ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () => _onEntradasTap(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFF993A84),
              border: Border.all(
                color: Color(0xFF993A84)
              ),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Text(
              'Entradas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

);
  }

void _onEntradasTap(BuildContext context) async {
  await launchUrl(Uri.parse(event.buyLink));
  await Future.delayed(Duration(seconds: 4));
  final action = await AlertDialogsInteractive.yesCancelDialog(
    context,
    'Responda',
    '¿Compraste una entrada?',
    'No',
    'Si',
    Colors.green
  );
  if (action == DialogsAction.yes) {
    _addHistory();
  }
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











