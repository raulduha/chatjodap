import 'dart:async';


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../marker_provider.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  late GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final MarkerProvider markerProvider = MarkerProvider();
  List<Marker> markers = [];

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  DateTime filterDate = DateTime.now();
  List<Marker> filteredMarkers = [];

  final TextEditingController searchController = TextEditingController();
  bool isSearchBarVisible = false;
  FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _getCurrentLocation() async {
    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _getMarkers();
  }

  static const CameraPosition _SantiagoCL = CameraPosition(
    target: LatLng(-33.447487, -70.673676),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _getMarkers();
    _getCurrentLocation();
    markers = filteredMarkers;
  }

  Widget buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search addresses',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onSubmitted: (value) {
        _placeSearchMarker(value);
      },
    );
  }

void _placeSearchMarker(String address) async {
  if (address.isNotEmpty) {
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location location = locations.first;
      LatLng latLng = LatLng(location.latitude, location.longitude);

      // Create a temporary marker
      Marker searchMarker = Marker(
        markerId: MarkerId('searchMarker'),
        position: latLng,
      );

      setState(() {
        markers = [searchMarker];
      });

      // Move the camera to the temporary marker's position
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid address or unable to retrieve coordinates.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


  void _getMarkers() async {
    final eventsSnapshot = await _database.ref().child("events").once();
    final eventsData = eventsSnapshot.snapshot.value as Map<dynamic, dynamic>;

    final addresses = <String>[];
    final names = <String>[];
    final dates = <String>[];

    if (eventsData != null) {
      eventsData.forEach((key, value) {
        final address = value['address'];
        final name = value['name'];
        final date = value['date'];
        addresses.add(address);
        names.add(name);
        dates.add(date);
      });
    }

    markers = await markerProvider.getMarkersFromAddresses(addresses, names, dates);
    filteredMarkers = markers;
    setState(() {});

    final defaultDate = DateTime.now();
    _filterMarkers(defaultDate);
  }

  void _filterMarkers(DateTime date) {
    setState(() {
      filterDate = date;
      filteredMarkers = markers.where((markers) {
        String eventDate;
        if (markers.infoWindow.snippet != null) {
          eventDate = markers.infoWindow.snippet!;
        } else {
          eventDate = "Unknown";
        }
        final eventTimestamp = DateTime.parse(eventDate).millisecondsSinceEpoch;

        return eventTimestamp >= date.millisecondsSinceEpoch &&
            eventTimestamp < date.add(const Duration(days: 1)).millisecondsSinceEpoch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 39, 1),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;
                if (isSearchBarVisible) {
                  FocusScope.of(context).requestFocus(searchFocusNode);
                } else {
                  searchController.clear();
                }
              });
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(36, 36, 39, 1),
        title: Container(
          height: 50,
          color: const Color.fromRGBO(36, 36, 39, 1),
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Text(
                'MAPA',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF993A84),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: filteredMarkers.isNotEmpty ? Set<Marker>.of(filteredMarkers) : Set<Marker>.of([]),
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _SantiagoCL,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              newGoogleMapController.setMapStyle('''
                    [
                      { "featureType": "poi", "elementType": "labels", "stylers": [ { "visibility": "off" } ] },
                      { "elementType": "geometry", "stylers": [ { "color": "#242f3e" } ] },
                      { "elementType": "labels.text.fill", "stylers": [ { "color": "#746855" } ] },
                      { "elementType": "labels.text.stroke", "stylers": [ { "color": "#242f3e" } ] },
                      { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#d59563" } ] },
                      { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#d59563" } ] },
                      { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#263c3f" } ] },
                      { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#6b9a76" } ] },
                      { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#38414e" } ] },
                      { "featureType": "road", "elementType": "geometry.stroke", "stylers": [ { "color": "#212a37" } ] },
                      { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "color": "#9ca5b3" } ] },
                      { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#746855" } ] },
                      { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#1f2835" } ] },
                      { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#f3d19c" } ] },
                      { "featureType": "transit", "elementType": "geometry", "stylers": [ { "color": "#2f3948" } ] },
                      { "featureType": "transit.station", "elementType": "labels.text.fill", "stylers": [ { "color": "#d59563" } ] },
                      { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#17263c" } ] },
                      { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#515c6d" } ] },
                      { "featureType": "water", "elementType": "labels.text.stroke", "stylers": [ { "color": "#17263c" } ] }
                    ]
                ''');

              setState(() {
                bottomPaddingOfMap = 130.0;
              });
            },
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: filterDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF993A84),
                            onPrimary: Colors.white,
                            onSurface: Color(0xFF993A84),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF993A84),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (selectedDate != null) {
                    _filterMarkers(selectedDate);
                    setState(() {
                      filterDate = selectedDate;
                    });
                  }
                },
                child: const Text(
                  'Filtrar por fecha',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF993A84)),
                ),
              ),
            ),
          ),

          // Search bar
          if (isSearchBarVisible) buildSearchBar2(),
        ],
      ),
    );
  }

Widget buildSearchBar2() {
  return Container(
    color: Colors.white,
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        
        hintText: 'Search addresses',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onEditingComplete: () {
        _placeSearchMarker(searchController.text);
      },
    ),
  );
}

}
