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
  List<Event> filteredSearch = [];
  late String searchText;

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  void _getEvents() {
    FirebaseDatabase.instance.ref().child("events").onValue.listen((event) {
      DataSnapshot eventsDataSnapshot = event.snapshot;
      final Map<dynamic, dynamic> eventsData = eventsDataSnapshot.value as Map<dynamic, dynamic>;
      eventsData.forEach((eventId, eventData) {
        Event event = Event.fromJson(eventData);
        events.add(event);
      });
      setState(() {
        filteredSearch = events;
      });
    });
  }

  void _filterEvents(String searchText) {
    setState(() {
      filteredSearch = events.where((event) {
        return  event.name.toLowerCase().contains(searchText.toLowerCase()) ||
                event.address.toLowerCase().contains(searchText.toLowerCase()) ||
                event.date.toLowerCase().contains(searchText.toLowerCase()) ||
                event.time.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        leading: Image.asset('images/binario1.png', 
            width: 10.0,
            height: 10.0,
            fit: BoxFit.cover,
            ),  
        title: const Text('Upcoming Events'),
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
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (text) {
                _filterEvents(text);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSearch.length,
              itemBuilder: (context, index) {
                filteredSearch.sort((event1, event2) => event1.date.compareTo(event2.date));
                return EventCard (
                  eventName: filteredSearch[index].name,
                  eventLocation: filteredSearch[index].address,
                  eventDate: '${filteredSearch[index].date} ${filteredSearch[index].time}', 
                  event: filteredSearch[index], 
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


        
