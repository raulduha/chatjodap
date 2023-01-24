// registration_screen.dart
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'bottom_nav_bar.dart';
import 'package:shadow_overlay/shadow_overlay.dart';



class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

@override
  Widget build(BuildContext context) {

    MaterialColor color = Colors.green;

    return Scaffold(
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: true,
      
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;
            return StreamBuilder(
              stream: _database
                  .ref()
                  .child('users')
                  .child(user?.uid ?? '')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data?.snapshot.value != null) {
                  Map<dynamic, dynamic> userData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;
                  
                  return Column(
                    children: <Widget>[

                      Stack(
                        
                        children: <Widget>[


                          ShadowOverlay(
                            shadowWidth: 400,
                            shadowHeight: 250,
                            shadowColor: Colors.black,
                            child:
                              Image.asset(
                                'assets/images/party2.jpg',
                                height: 300,
                                width: 450,
                                fit: BoxFit.scaleDown,
                              ),
                            
                          ),




                          Column(
                            
                            children: [

                              const SizedBox(height: 220,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userData['name'],
                                    style: const TextStyle(fontSize: 30.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(width: 10),
                                  Text(
                                    userData['lastname'],
                                    style: const TextStyle(fontSize: 30.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),
                              Text(
                                    userData['email'],
                                    style: const TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.normal),
                              ),

                            ],

                          ),
                          
                          
                          

                        ],
                      ),




                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Icon(Icons.favorite), // <-- Icon
                                          Text("Favourites"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Icon(Icons.history), // <-- Icon
                                          Text("History"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),

                      

                      const SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.help), // <-- Icon
                                          Text("Help"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.edit), // <-- Icon
                                          Text("Edit"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),


                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.person_add), // <-- Icon
                                          Text("Invite"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox.fromSize(
                                size: Size(80, 80),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                      splashColor: Colors.white, 
                                      onTap: () {}, 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.logout), // <-- Icon
                                          Text("Logout"), // <-- Text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),



                    // Botón Logout horizontal largo

                    //   const SizedBox(height: 70,),
                    //   Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 50),
                    //   child: Center(
                    //     child: ElevatedButton(

                    //       onPressed: () {
                    //         // hacer Logout
                    //         print("pressed");
                            
                    //       },

                    //       style: ButtonStyle(
                    //         minimumSize: MaterialStateProperty.all(const Size(100, 35)),
                    //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    //         backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
                    //         textStyle: MaterialStateProperty.all(
                    //           const TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
                    //         ),
                    //       ),


                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         // mainAxisSize: MainAxisSize.min,
                    //         children: const [
                    //           Icon(Icons.logout),
                    //           SizedBox(width: 5),
                    //           Text('Logout'),
                    //         ],
                    //       )

                          
                    //     ),
                    //   ),
                    // ),

                    ],
                  );

















                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}







