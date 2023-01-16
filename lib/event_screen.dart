import 'bottom_nav_bar.dart';
import 'package:flutter/material.dart';


class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String _searchText = "";
  String? _selectedTypeOfMusic = "All";
  String? _selectedAgeRange = "All";
  String? _selectedDistance = "Any";

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
            child: ListView(
              children: [
                
              ],
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
                          _selectedTypeOfMusic = value;
                        });
                      },
                    ),
                  ),
                ),





                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        DropdownButton<String>(
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
                              child: Text("26-35"),
                              value: "26-35",
                            ),
                            DropdownMenuItem(
                              child: Text("36-45"),
                              value: "36-45",
                            ),
                            DropdownMenuItem(
                              child: Text("46+"),
                              value: "46+",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedAgeRange = value;
                            });
                          },
                    
                          hint: Text("Age range"),
                        ),
                        SizedBox(height: 10),
                        DropdownButton<String>(
                          value: _selectedDistance,
                          items: [
                            DropdownMenuItem(
                              child: Text("All"),
                              value: "All",
                            ),
                            DropdownMenuItem(
                              child: Text("5km"),
                              value: "5km",
                            ),
                            DropdownMenuItem(
                              child: Text("10km"),
                              value: "10km",
                            ),
                            DropdownMenuItem(
                              child: Text("25km"),
                              value: "25km",
                            ),
                            DropdownMenuItem(
                              child: Text("50km"),
                              value: "50km",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedDistance = value;
                            });
                          },
                          hint: Text("Distance"),
                          ),
                      ],
                    ),
                  )
                )
              ]
            )
          )
        ]
      )
    );
} }