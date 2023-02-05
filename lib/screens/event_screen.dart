import '../bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../event_getter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import '../event_getter.dart';
import '../widgets/Divider.dart';
import '../event_detail_page.dart';
import 'home_page.dart';
import 'package:firebase_database/firebase_database.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}
class _EventsPageState extends State<EventsPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  void _getEvents() {
    FirebaseDatabase.instance.reference().child("events").onValue.listen((event) {
      DataSnapshot eventsDataSnapshot = event.snapshot;
      final Map<dynamic, dynamic> eventsData = eventsDataSnapshot.value as Map<dynamic, dynamic>;
      eventsData.forEach((eventId, eventData) {
        Event event = Event.fromJson(eventData);
        events.add(event);
      });
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Text('Events'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for events',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[800],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCard(
                  eventName: events[index].name,
                  eventLocation: events[index].address,
                  eventDate: '${events[index].date} ${events[index].time}', 
                  event: events[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
