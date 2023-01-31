import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../event_detail_page.dart';
import '../event_getter.dart';

class HomePage extends StatefulWidget {

  const HomePage({final Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Event> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  Future<void> _getEvents() async {
    try {
      final eventsSnapshot = await _database.reference().child("events").once();
      final eventsData = eventsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      if (eventsData != null) {
        eventsData.forEach((key, value) {
          final event = Event.fromJson(key, value);
          _events.add(event);
        });
      }
      _events.sort((a, b) => a.date.compareTo(b.date)); // hay que hacer que se ordene bien por fecha
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen news'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.date),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(event: event),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}