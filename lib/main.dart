import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:flutter_application_1/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';
import 'screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    
    child: MaterialApp(
      title: 'Your App',
      initialRoute: '/home',
      onGenerateRoute: Routers.generateRoute,
        
      // initialRoute: FirebaseAuth.instance.currentUser == null ? Loginscreen.idScreen :MainScreen.idScreen,
      routes: 
      {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
      },
    )
  );
    
}

