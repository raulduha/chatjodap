import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class Event {
  final String name;
  final String address;
  final String date;
  final String time;
  final String description;
  final String type;

  Event( {required this.time, required this.description, required this.address,required this.name, required this.type, required this.date});

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    return Event(
      name: json['name'],
      address: json['address'],
      date: json['date'],
      time: json['time'],
      description: json['description'],
      type: json['type'],

    );
  }
}
