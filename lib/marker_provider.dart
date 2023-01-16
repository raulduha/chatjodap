import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MarkerProvider {
  //static const _apiKey = 'AIzaSyADfCV_QEzetFvQ5MG4Hj0zH3QBYX-F0hU';
  final Location _location = Location();
  

  Future<List<Marker>> getMarkersFromAddresses(List<String> addresses) async {
    final markers = <Marker>[];
    for (final address in addresses) {
      final coordinates = await _getCoordinatesFromAddress(address);
      markers.add(Marker(
        markerId: MarkerId(address),
        position: coordinates,
        infoWindow: InfoWindow(title: address),
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
