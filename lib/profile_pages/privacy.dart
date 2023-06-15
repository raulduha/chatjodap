import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
            appBar: AppBar(
  backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
  title: Container(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'Privacidad',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF993A84),
      ),
    ),
  ),
),
        
      
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:  
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [

                Text("PRIVACIDAD")
              ],
            ),
          ),



      ),
    );
  }
}