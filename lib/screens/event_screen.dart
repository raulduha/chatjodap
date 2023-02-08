
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import '../event_getter.dart';
import 'package:location/location.dart';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geo;
import 'home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';
import 'dart:math';
class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Event> events = [];
  List<Event> filteredSearch = [];
  List<Event> originalEvents = [];
  late String searchText;
  late geo.Position currentPosition;

  @override
  void initState() {
    super.initState();
    _getEvents();
  }
  
  double haversine(double lat1, double lon1, double lat2, double lon2) {
  double dlat = (lat2 - lat1) * (pi / 180);
  double dlon = (lon2 - lon1) * (pi / 180);
  double a = pow(sin(dlat / 2), 2) +
      cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) * pow(sin(dlon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double d = 6371 * c;
  return d;
}
  void _getEvents() async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final eventsRef = database.ref().child("events");
  final eventsSnapshot = await eventsRef.once();
  Map<dynamic, dynamic> eventsMap = (eventsSnapshot.snapshot.value) as Map<dynamic, dynamic>;
  List<Event> events = [];

  eventsMap.forEach((key, value) {
    final event = Event.fromJson(value);
    events.add(event);
  });

  currentPosition = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
  List<Event> eventsWithCoordinates = await Future.wait(events.map((event) async {
    final locations = await geocoding.locationFromAddress(event.address);
    final location = locations.first;
    event.lati = location.latitude;
    event.longi = location.longitude;
    return event;
  }));

  setState(() {
      events = eventsWithCoordinates
        ..sort((event1, event2) => haversine(currentPosition.latitude, currentPosition.longitude, event1.lati, event1.longi)
            .compareTo(haversine(currentPosition.latitude, currentPosition.longitude, event2.lati, event2.longi)));
      originalEvents = events;
      filteredSearch = events;
    });
  }


  void _filterEvents(String searchText) {
    setState(() {
      filteredSearch = originalEvents.where((event) {
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
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
        leading: Image.asset('images/binario1.png', 
            width: 10.0,
            height: 10.0,
            fit: BoxFit.cover,
            ),  
        title: const Text('Events close to you'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for events',
                prefixIcon: const Icon(Icons.search),
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
            
            child: filteredSearch.isEmpty 
              ? Center(child: filteredSearch == events ? const Text("No events found") : const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)))
              : ListView.builder(
              itemCount: filteredSearch.length,
              itemBuilder: (context, index) {
                filteredSearch.sort((event1, event2) => haversine(currentPosition.latitude, currentPosition.longitude, event1.lati, event1.longi)
                    .compareTo(haversine(currentPosition.latitude, currentPosition.longitude, event2.lati, event2.longi)));
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