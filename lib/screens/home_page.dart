
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../event_detail_page.dart';
import '../event_getter.dart';

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

  void _loadData() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference eventsRef = database.reference().child("events");
    final eventsSnapshot = await eventsRef.once();
    Map<dynamic, dynamic> eventsMap = (eventsSnapshot.snapshot.value) as Map<dynamic, dynamic>;
    List<Event> events = [];
    eventsMap.forEach((key, value) {
    final event = Event.fromJson(value);
    events.add(event);
  });
    setState(() {
      _recommendedEvents = events
        .where((event) => event.promocionar != null )
        .toList()
        ..sort((a, b) => a.date.compareTo(b.date));
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
                'Recommended Events',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _recommendedEvents.length,
                itemBuilder: (context, index) {
                  return EventCard(
                    event: _recommendedEvents[index], eventDate: '', eventLocation: '', eventName: '',
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Popular Events',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _popularEvents.length,
                itemBuilder: (context, index) {
                  return EventCard(
                    event: _popularEvents[index],eventDate: '', eventLocation: '', eventName: '',
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

  EventCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate, 
    required this.event,
  });

@override
Widget build(BuildContext context) {
return Container(
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
);
}
}