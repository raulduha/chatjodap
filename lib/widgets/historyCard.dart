import 'package:flutter/material.dart';
import 'package:flutter_application_1/feedback.dart';
class HistoryCard extends StatelessWidget {
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventType;

  HistoryCard({
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(27, 28, 28, 1),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: Colors.white),
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
              eventDate,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              eventLocation,
              style: TextStyle(
                color: Colors.white,
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
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Submit Feedback',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
