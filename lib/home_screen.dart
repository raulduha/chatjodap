import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_nav_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'marker_provider.dart';
import 'package:firebase_database/firebase_database.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final Completer<GoogleMapController> _controllerGoogleMap = Completer<GoogleMapController>();
    
    late GoogleMapController newGoogleMapController;
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    final MarkerProvider markerProvider = MarkerProvider();
    List<Marker> markers = [];

    late Position currentPosition;
    var geolocator = Geolocator();
    double bottomPaddingOfMap = 0;

    final FirebaseDatabase _database = FirebaseDatabase.instance;
  
  

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;

      LatLng latLatPosition = LatLng(position.latitude, position.longitude);

      CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    
    }

    static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getMarkers();

  }
  void _getMarkers() async {
    // Retrieve events data from Firebase
    final eventsSnapshot = await _database.reference().child("events").once();
  

    // Create a new list of addresses
    final addresses = <String>[];

    final eventsData = eventsSnapshot.snapshot.value as Map<dynamic, dynamic>;
    if (eventsData != null) {
    eventsData.forEach((key, value) {
    final address = value['address'];
    addresses.add(address);
  });
}

    // Call _getMarkers() function with the new list of addresses
    markers = await markerProvider.getMarkersFromAddresses(addresses);
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAPA')),
      body:
      Stack(
      children: [
          GoogleMap

          (
          markers: Set<Marker>.of(markers),
          
          padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller)

          {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;
        
            // for black theme google maps and no marker
            newGoogleMapController.setMapStyle('''
                    [
                      {    "featureType": "poi",    "elementType": "labels",    "stylers": [      {        "visibility": "off"      }    ]
  },
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
            
            setState(() {
              bottomPaddingOfMap = 130.0;
            });
            
            
            _getCurrentLocation();
            
            
          },
          

          
          ),
      ]
      
      ),
      
    );
  }
}
