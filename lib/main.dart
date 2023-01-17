import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'router.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      initialRoute: '/home',
      onGenerateRoute: Routers.generateRoute,
      
      //initialRoute: FirebaseAuth.instance.currentUser == null ? Loginscreen.idScreen :MainScreen.idScreen,
      routes: 
      {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(), // cambiar color para ingresar datos
         // cambiar color para ingresar datos
      },
    );
  }
}
