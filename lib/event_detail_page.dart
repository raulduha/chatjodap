
import 'package:flutter/material.dart';
import 'screens/event_screen.dart';
import 'event_getter.dart';
class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Text(event.name),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Name:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                event.name,
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Date and Time:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                '${event.date} ${event.time}',
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Description:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                event.description,
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Type:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                event.type,
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Address:",
                style: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                event.address,
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              )
            )
          ]
        ),
      ),
    );
  }
}
