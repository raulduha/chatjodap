

import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventTime;
  final String eventType;
  final String eventDescription;

  EventCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
    required this.eventTime,
    required this.eventType,
    required this.eventDescription,
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
            '$eventDate, $eventTime',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            eventType,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            eventDescription,
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
