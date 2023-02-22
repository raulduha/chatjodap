import 'package:flutter/material.dart';
import 'package:flutter_application_1/feedback.dart';

class HistoryCard extends StatefulWidget {
  final String eventName;
  final String eventAddress;
  final String eventDate;
  final String eventType;

  HistoryCard({
    required this.eventName,
    required this.eventAddress,
    required this.eventDate,
    required this.eventType,
    
  });


  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {

  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(36, 36, 39, 1), 
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Color.fromRGBO(36, 36, 39, 1), ),
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
                  widget.eventName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              widget.eventDate,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.eventAddress,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.eventType,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: isButtonEnabled ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage(
                    event_name: widget.eventName,
                    event_date: widget.eventDate,
                    event_type: widget.eventType,
                    event_address: widget.eventAddress,
                    
                  )),
                );
              } : null,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF993A84),
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
