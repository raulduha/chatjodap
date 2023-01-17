import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';

import 'package:geolocator/geolocator.dart';
import 'dart:math';

class Event {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String type;
  final String address;
  final double latitude;
  final double longitude;
  late double distance;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,



  });

    factory Event.fromJson(String key, Map<dynamic, dynamic> value) {
    return Event(
      id: key,
      name: value['name'],
      description: value['description'],
      date: value['date'],
      time: value['time'],
      type: value['type'],
      address: value['address'],
      latitude: value['latitude'],
      longitude: value['longitude']
    );
  }
}

class EventGetter {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<List<Event>> getEvents() async {
    final events = <Event>[];
    try {
      final currentPosition = await Geolocator.getCurrentPosition();
      final eventsSnapshot = await _database.reference().child("events").once();
      final eventsData = eventsSnapshot.snapshot.value as Map<dynamic, dynamic>;
      if (eventsData != null) {
        eventsData.forEach((key, value) {
          final event = Event.fromJson(key, value);
          event.distance = Geolocator.distanceBetween(
            currentPosition.latitude, 
            currentPosition.longitude, 
            event.latitude, 
            event.longitude
          );
          events.add(event);
        });

            }
    } catch (e) {
      print(e);
    }
    return events..sort((a, b) => a.distance.compareTo(b.distance));
  }
}