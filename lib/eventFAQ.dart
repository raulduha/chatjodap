import 'package:flutter/material.dart';

class EventFAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Row(
          children: [
            Image.asset('images/binario1.png', 
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
            ),   
            SizedBox(width: 16.0),
            Container(
  child: Image.asset('images/faq.png',
  height: 50,
  
  )
),
          ],
        ),
      ),
        body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. What is the event finder app about?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("The event finder app is a platform that helps users discover and attend various events in their area.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("2. How does the app work?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("The app uses the user's location to show them a list of events happening near them. They can then filter the events based on their preferences and choose to attend an event.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("3. Is the app free to use?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("Yes, the app is free to download and use.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("4. Do I need to create an account to use the app?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("Yes, you need to create an account to access all the features of the app and RSVP to events.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("5. Can I add my own event to the app?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("Yes, the app allows users to add their own events and promote it to a wider audience.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("6. How do I know if an event is suitable for me?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("The app provides a detailed description of each event and its target audience, which can help you determine if the event is suitable for you.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("7. Can I view events happening in other cities?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("Yes, the app allows you to search for events in any location by entering the city name.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("8. How do I contact the event organizer if I have a question?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
                            Text("You can contact the event organizer through the app by using the contact information provided in the event details page.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("9. Can I cancel my RSVP for an event?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("Yes, you can cancel your RSVP for an event if you change your mind. Simply go to the event details page and click on the 'Cancel RSVP' button.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("10. How will I know if an event is cancelled?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("The app will send you a notification if an event you have RSVP'd to is cancelled by the event organizer.",style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

