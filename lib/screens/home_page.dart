
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as location;
import '../event_detail_page.dart';
import '../event_getter.dart';
import 'dart:math';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geo;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> _recommendedEvents = [];
  List<Event> _popularEvents = [];

  @override
  void initState() {
    super.initState();
    _loadData();
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

  void _loadData() async {
    
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference eventsRef = database.ref().child("events");
    final eventsSnapshot = await eventsRef.once();
    Map<dynamic, dynamic> eventsMap = (eventsSnapshot.snapshot.value) as Map<dynamic, dynamic>;
    List<Event> events = [];
    eventsMap.forEach((key, value) {
    final event = Event.fromJson(value);
    events.add(event);
  });
  Position currentPosition = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);

  List<Event> eventsWithCoordinates = await Future.wait(events.map((event) async {
    List<geocoding.Location> locations = await  geocoding.locationFromAddress(event.address);
    geocoding.Location location = locations.first;
    event.lati = location.latitude;
    event.longi = location.longitude;
    
    return event;
  }));
    setState(() {
      _recommendedEvents = events
        .where((event) => event.promocionar != null )
        .toList()
        ..sort((a, b) => haversine(currentPosition.latitude, currentPosition.longitude, a.lati, a.longi)
            .compareTo(haversine(currentPosition.latitude, currentPosition.longitude, b.lati, b.longi)));
      _popularEvents = events
        .where((event) => event.promocionar == 'si')
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        
        title: Text('Home'),
        
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Closest Events Recommended',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: (_recommendedEvents.length == 0)
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _recommendedEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: _recommendedEvents[index],
                          eventDate: '',
                          eventLocation: '',
                          eventName: '',
                        );
                      },
                    ),
            ),
            
            
              
            Image.asset('images/popularevents.png', 
            width: 400.0,
            height: 50.0,
            fit: BoxFit.cover,
            ),          
            Expanded(
              child: (_popularEvents.length == 0)
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _popularEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: _popularEvents[index],
                          eventDate: '',
                          eventLocation: '',
                          eventName: '',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
class EventCard extends StatelessWidget {
  final Event event;
  final String eventName;
  final String eventLocation;
  final String eventDate;
  late double eventDis;

  EventCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate, 
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EventDetailPage(event: event),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              event.address,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              event.date,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18.0,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}