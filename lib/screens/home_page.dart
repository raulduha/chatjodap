import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../event_detail_page.dart';
import '../event_getter.dart';

class HomePage extends StatelessWidget {
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
              child: ListView(
                children: <Widget>[
                  EventCard(
                    eventName: 'Event 1',
                    eventLocation: 'Location 1',
                    eventDate: '01-01-2023',
                  ),
                  EventCard(
                    eventName: 'Event 2',
                    eventLocation: 'Location 2',
                    eventDate: '02-01-2023',
                  ),
                  EventCard(
                    eventName: 'Event 3',
                    eventLocation: 'Location 3',
                    eventDate: '03-01-2023',
                  ),
                ],
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
              child: ListView(
                children: <Widget>[
                  EventCard(
                    eventName: 'Event 4',
                    eventLocation: 'Location 4',
                    eventDate: '04-01-2023',
                  ),
                  EventCard(
                    eventName: 'Event 5',
                    eventLocation: 'Location 5',
                    eventDate: '05-01-2023',
                  ),
                  EventCard(
                    eventName: 'Event 6',
                    eventLocation: 'Location 6',
                    eventDate: '06-01-2023',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class EventCard extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventDate;

  EventCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
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
          Row(
            children: <Widget>[
              Icon(Icons.emoji_symbols_outlined),
              SizedBox(width: 10.0),
              Text(
                eventName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            eventLocation,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            eventDate,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
