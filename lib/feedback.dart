import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_pages/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/widgets/historyCard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackPage extends StatefulWidget {

  final String event_name;
  final String event_date;
  final String event_type;
  final String event_address;

  const FeedbackPage({
    Key? key, 
    required this.event_name, 
    required this.event_date, 
    required this.event_type, 
    required this.event_address,

  }) : super(key: key);

  

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {


  String? _comment;
  int _rating = 0;

  bool _isButtonEnabled = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate this event:',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 8),
            RatingWidget(
              rating: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _comment != null ? Colors.purple : Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                hintText: 'Leave a comment (optional)',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  _comment = value;
                });
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.purple,
              ),
              onPressed: _isButtonEnabled ?  () {

                print("Feedback data:");
                print(_comment);
                print(_rating.toString());

                // meter feedback a la compañia/feedbacks/

                addFeedback(widget.event_name, widget.event_date, widget.event_type, widget.event_address);
                Navigator.pop(context);

              } : null,
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }







  void addFeedback (String eventName, String eventDate, String eventType, String eventAddress) async {

    try {
      
      // obtener user id
      User? user = _auth.currentUser;
      final userSnapshot =  _database.ref().child("users").child(user!.uid);
      String? userId = user.uid;
      print(userId);

      // obtener event id

      Map<String, dynamic> eventData = {
        "name": eventName,
        "date": eventDate,
        "address": eventAddress,
        "type": eventType,
      };
      // print("EVENTDATA");
      // print(eventData);

      var eventId;
      var promotoraId;

      DatabaseReference eventsRef = FirebaseDatabase.instance.ref().child("events");
      eventsRef.onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> events = snapshot.value as Map<dynamic, dynamic>;
        for (String eventID in events.keys) {
          Map<dynamic, dynamic> eventDataMap = events[eventID];
          if (events[eventID]["name"] == eventData["name"] && 
            events[eventID]["date"] == eventData["date"] &&
            events[eventID]["type"] == eventData["type"] &&
            events[eventID]["address"] == eventData["address"])
            {
              print("Coincidencia!");
              print("The event ID is: $eventID");
              eventId = eventID;
              break;
            }
        }
        if (eventId != null) {

          // obtener promotora

          DatabaseReference eventRef = _database.ref().child("events").child(eventId);
          eventRef.once().then((DatabaseEvent event) async {
            Object? eventSnapshot = event.snapshot.value;
            print(eventSnapshot);
            if (eventSnapshot!= null) {
              Map<dynamic, dynamic> eventSnapshotMap = eventSnapshot as Map<dynamic, dynamic>;
              // print(eventSnapshotMap['promotoraid']);
              promotoraId = eventSnapshotMap['promotoraid'];
              

              // Mapear uid, eid con rating y comentario en la compañia

              Map<dynamic, dynamic> feedbackData = {
                "userid": userId,
                "eventid": eventId,
                "rating": _rating,
                "comment": _comment,
              };

              print(feedbackData);


              // añadir a la bdd, dependiendo de si existe o no el nodo feedbacks.

              String promotoraIdString = promotoraId.toString();
              final companySnapshot =  _database.ref().child("companies").child(promotoraIdString);
              final companyFeedback = await companySnapshot.child("feedbacks").once();

              if (companyFeedback.snapshot.value != null) {
                print("VALIDO");
                companySnapshot.child("feedbacks").push().set(feedbackData);
                
              }
              else {
                print("NO HAY NODO FEEDBACK");
                companySnapshot.child("feedbacks").push().set(feedbackData);
                
              }

              Fluttertoast.showToast(msg: "Muchas gracias por dar feedback al evento!");

            }

            
          });


          


        }
      });


    } catch (e) {
      print(e);
    }


  }


}








class RatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;

  const RatingWidget({
    Key? key,
    required this.rating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF993A84),),
                color: i <= rating ? const Color.fromRGBO(28, 27, 27, 1) : const Color.fromRGBO(28, 27, 27, 1),
              ),
              child: Center(
                child: i <= rating
                    ? Image.asset(
                        'images/disco_ball_nb.png',
                        width: 48,
                        height: 48,
                      )
                    : Text(
                        '$i',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
            onTap: () {
              onChanged(i);
            },
          ),
      ],
    );
  }
}




