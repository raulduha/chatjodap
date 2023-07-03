
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
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
  bool _showUpcoming = false;
  int _selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadData();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Set loading state to false after 2 seconds
      });
    });
  }
  bool _isLoading = true;

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
    Map<dynamic, dynamic> eventsMap =
        (eventsSnapshot.snapshot.value) as Map<dynamic, dynamic>;
    List<Event> events = [];
    eventsMap.forEach((key, value) {
      final event = Event.fromJson(value);
      events.add(event);
    });

    final permission = await geo.Geolocator.requestPermission();
    geo.Position currentPosition =
        await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);

    List<Event> eventsWithCoordinates = await Future.wait(events.map((event) async {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(event.address);
      geocoding.Location location = locations.first;
      event.lati = location.latitude;
      event.longi = location.longitude;
      event.dis = haversine(
          currentPosition.latitude, currentPosition.longitude, event.lati, event.longi);

      return event;
    }));

  setState(() {
    // Filter out events by conditions
    DateTime currentDate = DateTime.now();
    double maxDistance = 1000000000000000.0; // Maximum distance in kilometer

    // Recommended
    _recommendedEvents = events
        .where((event) =>
            DateTime.parse(event.date).isAfter(currentDate) &&
            event.dis <= maxDistance)
            
        .toList()
      ..sort((event1, event2) => event1.dis.compareTo(event2.dis));
      
      //   .where((event) => event.promocionar != null)
      //   .toList()
      // ..sort((event1, event2) => event1.date.compareTo(event2.date));
        
      

    // Popular
    _popularEvents = events
        .where((event) =>
            event.promocionar == "si" &&
            DateTime.parse(event.date).isAfter(currentDate))
        .toList()
      ..sort((event1, event2) => event1.dis.compareTo(event2.dis));
  });


}
    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(36, 36, 39, 1),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(36, 36, 39, 1),
            elevation: 0, // Remove the blue line below the title
            title: Container(
              height: 50,
              color: const Color.fromRGBO(36, 36, 39, 1),
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: const [
                  Text(
                    'INICIO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF993A84),
                    ),
                  ),
                ],
              ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Make the buttons more round
                
              ),
              tabs: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showUpcoming = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), // Make the buttons more round
                      color: !_showUpcoming ? Colors.purple : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          color: !_showUpcoming ? Colors.white : Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showUpcoming = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), // Make the buttons more round
                      color: _showUpcoming ? Colors.purple : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Proximamente',
                        style: TextStyle(
                          color: _showUpcoming ? Colors.white : Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _showUpcoming = index == 1;
                });
              },
            ),
          ),
        ),
      ),


      
      body: _showUpcoming
          ? (_recommendedEvents.isEmpty)
              ? _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF993A84),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("No events found near by"),
                    )
              : ListView.builder(
                  itemCount: _recommendedEvents.length,
                  itemBuilder: (context, index) {
                    DateTime eventDate =
                        DateTime.parse(_recommendedEvents[index].date);
                    DateTime currentDate = DateTime.now();

                    return EventCard(
                      event: _recommendedEvents[index],
                      eventDate: '',
                      eventLocation: '',
                      eventName: '',
                      eventMage: _recommendedEvents[index].mage,
                      eventFage: _recommendedEvents[index].fage,
                      eventPic: _recommendedEvents[index].picture,
                    );

                  },
                )


          : (_popularEvents.isEmpty)
              ? _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF993A84),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("No events found"),
                    )
              : ListView.builder(
                  itemCount: _popularEvents.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                      event: _popularEvents[index],
                      eventDate: '',
                      eventLocation: '',
                      eventName: '',
                      eventMage: _popularEvents[index].mage,
                      eventFage: _popularEvents[index].fage,
                      eventPic: _popularEvents[index].picture,
                    );
                  },
                ),

    ),
  );
}
}


// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  final Event event;
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventFage;
  final String eventMage;
  final String eventPic;
  late double eventDis;

  EventCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
    required this.event,
    required this.eventFage,
    required this.eventMage,
    required this.eventPic,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EventDetailPage(event: event),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(36, 36, 39, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 90.0,
                  width: 90.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: event.picture != null
                          ? NetworkImage(event.picture)
                          : const AssetImage('images/event_card_image.jpg') as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text(
                        event.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 181, 181, 181),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              event.address.split(',').sublist(0, 2).join(','),
                              style: TextStyle(
                                color: Color.fromARGB(255, 181, 181, 181),
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 181, 181, 181),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            event.date,
                            style: TextStyle(
                              color: Color.fromARGB(255, 181, 181, 181),
                              fontSize: 15.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'M: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            eventFage,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            'H: ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            eventMage,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: const Color.fromARGB(255, 69, 68, 68),
          ),
        ],
      ),
    );
  }
}
