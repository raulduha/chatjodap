import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_pages/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String? _comment;
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate this event:',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 8),
            RatingWidget(
              rating: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
  style: const TextStyle(color: Colors.white),
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: _comment != null ? Color(0xFF993A84): Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF993A84)),
    ),
    hintText: 'Leave a comment (optional)',
    hintStyle: const TextStyle(color: Colors.white),
  ),
  maxLines: null,
  onChanged: (value) {
    setState(() {
      _comment = value;
    });
  },
),

            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF993A84),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                // TODO: save feedback to database
                Navigator.pop(context);
              },
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;

  const RatingWidget({
    Key? key,
    required this.rating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF993A84),),
                color: i <= rating ? const Color.fromRGBO(28, 27, 27, 1) : const Color.fromRGBO(28, 27, 27, 1),
              ),
              child: Center(
                child: i <= rating
                    ? Image.asset(
                        'images/disco_ball_nb.png',
                        width: 48,
                        height: 48,
                      )
                    : Text(
                        '$i',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
            onTap: () {
              onChanged(i);
            },
          ),
      ],
    );
  }
}
