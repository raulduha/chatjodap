
import 'package:flutter/material.dart';
import 'event_screen.dart';
import 'event_getter.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({Key? key, required this.event}) : super(key: key);

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(event.name, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text('${event.date} ${event.time}', style: TextStyle(fontSize: 18.0)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(event.description, style: TextStyle(fontSize: 18.0)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text('Type: ${event.type}', style: TextStyle(fontSize: 18.0)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text('Address: ${event.address}', style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}
