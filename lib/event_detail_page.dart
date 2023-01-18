
import 'package:flutter/material.dart';
import 'event_screen.dart';
import 'event_getter.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
 
  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Column(
        children: [
          Text(event.name),
          Text(event.date),
          Text(event.time),
          Text(event.description),
          Text(event.type),
          Text(event.address),
        ],
      ),
    );
  }
}
