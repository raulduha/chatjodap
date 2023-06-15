import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/facebook_sign_in.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';

import 'package:provider/provider.dart';
import 'router.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    
    create: (context) => GoogleSignInProvider(),

    child: ChangeNotifierProvider(
      create: (context) => FacebookSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        initialRoute: '/login',
        onGenerateRoute: Routers.generateRoute,
        routes: 
        {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
        },
      )
    ),

  );
}

