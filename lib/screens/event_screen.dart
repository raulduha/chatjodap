
import 'package:flutter/material.dart';

import '../event_getter.dart';


import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geo;
import 'home_page.dart';
import 'package:firebase_database/firebase_database.dart';

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

  // REQUEST PERMISO
  // ignore: unused_local_variable
  final permission = await geo.Geolocator.requestPermission();

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
      // Convert the event date to a string
      String dateString = event.date.toString();
      // Check if event date is greater than or equal to the current date
      return dateString.compareTo(DateTime.now().toString()) >= 0 &&
          (event.name.toLowerCase().contains(searchText.toLowerCase()) ||
          event.address.toLowerCase().contains(searchText.toLowerCase()) ||
          event.date.toLowerCase().contains(searchText.toLowerCase()) ||
          event.promotora.toLowerCase().contains(searchText.toLowerCase()) ||
          event.mage.toString().toLowerCase().contains(searchText.toLowerCase()) ||
          event.type.toString().toLowerCase().contains(searchText.toLowerCase()) ||
          event.starttime.toLowerCase().contains(searchText.toLowerCase()));
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 39, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 36, 39, 1),
        
        title: Container(
  height: 50,
  color: const Color.fromRGBO(36, 36, 39, 1),
  padding: const EdgeInsets.only(left: 16),
  child: Row(
    children: [
      Text(
        'Eventos Cercanos',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF993A84),
        ),
      ),
    ],
  ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Busca eventos',
                hintStyle: TextStyle(color: Color.fromRGBO(36, 36, 39, 1)),
                prefixIcon: Icon(Icons.search, color:Color.fromRGBO(36, 36, 39, 1)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Color.fromRGBO(28, 27, 27, 1)),
              onChanged: (text) {
                _filterEvents(text);
              },
            ),
          ),
          Expanded(
            
            child: filteredSearch.isEmpty 
              ? Center(child: filteredSearch == events ? const Text("No events found") : const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF993A84),)))
              : ListView.builder(
              itemCount: filteredSearch.length,
              itemBuilder: (context, index) {
                filteredSearch.sort((event1, event2) => haversine(currentPosition.latitude, currentPosition.longitude, event1.lati, event1.longi)
                    .compareTo(haversine(currentPosition.latitude, currentPosition.longitude, event2.lati, event2.longi)));
                var eventDateTime = DateTime.parse("${filteredSearch[index].date} ${filteredSearch[index].starttime}");
                var currentDateTime = DateTime.now();
                if (eventDateTime.millisecondsSinceEpoch < currentDateTime.millisecondsSinceEpoch) {
                  return Container();
                }
                return EventCard (
                  eventName: filteredSearch[index].name,
                  eventLocation: filteredSearch[index].address,
                  eventDate: '${filteredSearch[index].date} ${filteredSearch[index].starttime}', 
                  event: filteredSearch[index], 
                  eventMage: filteredSearch[index].mage,
                  eventFage: filteredSearch[index].fage,
                  eventPic: filteredSearch[index].picture,
                );
              
              },
            ),
          ),
        ],
      ),
    );
  }
}
