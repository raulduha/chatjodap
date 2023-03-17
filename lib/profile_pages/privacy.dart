import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        title: const Text("Privacidad"),
          backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
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