import 'bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'event_getter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'event_getter.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final Location _location = Location();
  final EventGetter _eventGetter = EventGetter();
  String _searchText = "";
  String _selectedTypeOfMusic = "All";
  String _selectedAgeRange = "All";
  String _selectedDistance = "Any";
  List<Event> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await _location.getLocation();
      _eventGetter.getEvents().then((events) {
        setState(() {
          _isLoading = false;
          _events = events;
        });
      });
    } catch (e) {
      print(e);
    }
  }


    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(

                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final event = _events[index];
                      return ListTile(
                        title: Text(event.name),
                        
                        subtitle: Text("${event.distance}km"),
                        onTap: () {
                          // Navigate to event details page
                        },
                      );
                    },
                  ),
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: _selectedTypeOfMusic,
                      items: [
                        DropdownMenuItem(
                          child: Text("All"),
                          value: "All",
                        ),
                        DropdownMenuItem(
                          child: Text("Pop"),
                          value: "Pop",
                        ),
                        DropdownMenuItem(
                          child: Text("Rock"),
                          value: "Rock",
                        ),
                        // Add more types of music here
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedTypeOfMusic = value ?? "All";
                        });
                      },
                    ),
                  ),
                ),      
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: _selectedAgeRange,
                      items: [
                        DropdownMenuItem(
                          child: Text("All"),
                          value: "All",
                        ),
                        DropdownMenuItem(
                          child: Text("18-25"),
                          value: "18-25",
                        ),
                        
                        DropdownMenuItem(
                        child: Text("25-35"),
                        value: "25-35",
                        ),
                        DropdownMenuItem(
                        child: Text("35+"),
                        value: "35+",
                        )
                        ],
                        onChanged: (value) {
                        setState(() {
                        _selectedAgeRange = value  ?? "All";
                        });     
                        },
                    ),
                  ),
                ), 
                Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                        value: _selectedDistance,
                          items: [
                              DropdownMenuItem(
                              child: Text("Any"),
                              value: "Any",
                              ),
                              DropdownMenuItem(
                              child: Text("5km"),
                              value: "5",
                              ),
                              DropdownMenuItem(
                              child: Text("10km"),
                              value: "10",
                              ),
                              DropdownMenuItem(
                              child: Text("20km"),
                              value: "20",
                              ),
                              ],
                              onChanged: (value) {
                              setState(() {
                              _selectedDistance = value ?? "Any";
                              });
                            },
                          
                        
                      
                      
                    )
                  )
                )
              ]
            )
            )

        ]
        )
        );
        }}