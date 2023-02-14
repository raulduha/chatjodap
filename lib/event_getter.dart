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
  final String promocionar;
  final String promotora;
  final String buyLink;
  
  late double lati;
  late double longi;



  Event({required this.name, required this.address, required this.date,required this.time, required this.description, required this.type,required this.promocionar,required this.promotora,required this.buyLink,   });

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    return Event(
      name: json['name'],
      address: json['address'],
      date: json['date'],
      time: json['time'],
      description: json['description'],
      type: json['type'], 
      promocionar: json['promocionar'],
      promotora: json['promotora'],
      buyLink: json['buyLink']
      


    );
  }}
