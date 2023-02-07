
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';


class MarkerProvider {
  //static const _apiKey = 'AIzaSyADfCV_QEzetFvQ5MG4Hj0zH3QBYX-F0hU';
  //final Location _location = Location();
  //final FirebaseDatabase _database = FirebaseDatabase.instance;
  

  
  Future<List<Marker>> getMarkersFromAddresses(List<String> addresses, List<String> names, List<String> date) async {
    final byteData = await rootBundle.load("images/markerpink2.png");
    final image = Uint8List.view(byteData.buffer);
    
    final markers = <Marker>[];
    for (int i = 0; i < addresses.length; i++) {
        final coordinates = await _getCoordinatesFromAddress(addresses[i]);
        markers.add(Marker(
            
            markerId: MarkerId(addresses[i]),
            position: coordinates,
        
            infoWindow: InfoWindow(title: names[i],snippet: date[i]),
            icon: BitmapDescriptor.fromBytes(image),
            
            
        ));
    }
    return markers;
}

  Future<LatLng> _getCoordinatesFromAddress(String address) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyADfCV_QEzetFvQ5MG4Hj0zH3QBYX-F0hU';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final location = data['results'][0]['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception('Failed to get coordinates from address');
    }
  }
}
