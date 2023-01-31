import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(context) async {

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    try {
      UserCredential user_credential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Sign-in was successful
      print("sign in successful");
      final User? user = user_credential.user;

      
      print("is new user: ${user_credential.additionalUserInfo!.isNewUser}");
      if (user_credential.additionalUserInfo!.isNewUser) {

        String name = "";
        String last_name = "";

        if (user!.displayName != null) {
          final display_name = user.displayName!.split(" ");
          name = display_name[0];
          last_name = display_name[1];
        }

        print("firstName: $name");
        print("lastName: $last_name");

        final Map<String, dynamic> userData = {
          'email': user.email,
          'name': name,
          'lastname': last_name,
        };


        final ref = FirebaseDatabase.instance.ref().child('users').child(user.uid);
        String ref_string = ref.toString();
        print("this is th ref value: $ref_string");
        await ref.set(userData);
        
      }
      


      Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);

    } catch (error) {
      // Handle sign-in error
      print("sign in error: $error");
    }


    notifyListeners();
  }



  Future<void> googleLogout(context) async {
    try {
        // Sign out from Firebase Auth

        googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
        
        Navigator.pushReplacementNamed(context, '/login');

    } catch (e) {
        print("Error while logging out: $e");
    }
  }


}