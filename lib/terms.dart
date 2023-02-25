import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Row(
          children: [
            Container(
              child: Image.asset('images/terms.png',
              height: 40,
              
              )
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children:const  [
              Text("Terms and Conditions",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              Text("Purpose of the App:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("The JODAP Event Finder app (“App”) is designed to provide users with information about events happening all over Chile. The App allows users to search for events based on location, date, and type of event.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("User Information:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("To use the App, users must sign up with their full name, email, and age. JODAP COMPANY will not use user information for any purpose other than to improve the App and understand which events are of interest to users.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Content:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("JODAP COMPANY is responsible for the content that appears on the App. The content is sourced from a database of events in Chile, and is updated on a regular basis to ensure accuracy. Users are not able to upload or create content on the App.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Intellectual Property:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("The App and all of its content, including but not limited to text, images, and graphics, are the intellectual property of JODAP COMPANY. Users are not allowed to reproduce, modify, or distribute any of the content on the App without the express written consent of JODAP COMPANY.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Liability:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("JODAP COMPANY is not responsible for any errors or inaccuracies in the content on the App, or for any harm that may result from the use of the App or its content. JODAP COMPANY makes no warranties or representations of any kind, express or implied, about the completeness, accuracy, reliability, suitability, or availability with respect to the App or the information contained on the App.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Dispute Resolution:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("In the event of a dispute between a user and JODAP COMPANY, the user may report the dispute to JODAP COMPANY in writing. JODAP COMPANY will make every effort to resolve the dispute in a fair and efficient manner. If the dispute cannot be resolved, it may be brought to the appropriate court in Chile for resolution.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Changes to Terms and Conditions:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("JODAP COMPANY reserves the right to modify these Terms and Conditions at any time. Any changes to the Terms and Conditions will be posted on the App and will take effect immediately upon posting.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("Acceptance of Terms and Conditions:",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("By using the App, users are deemed to have accepted these Terms and Conditions in their entirety.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    }
  }
