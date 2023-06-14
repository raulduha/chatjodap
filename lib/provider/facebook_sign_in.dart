import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_database/firebase_database.dart';


class FacebookSignInProvider with ChangeNotifier{

  Map? userData;

  facebookLogin(context) async {
    try {
      var result = await FacebookAuth.i.login(
        permissions: ["public_profile", "email"],
      );
  
      // check the status of our login
      if (result.status == LoginStatus.success) {
        final requestData = await FacebookAuth.i.getUserData(
          fields: "email, name",
        );

        userData = requestData;
        print(userData);

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    

  }

  // logout
  facebookLogout(context) async {
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }



}