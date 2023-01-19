import 'package:flutter/material.dart';
import 'main.dart';
import 'loginScreen.dart';
import 'map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'registrationScreen.dart';
import 'package:flutter_application_1/widgets/progressDiaalog.dart';
import 'package:flutter_application_1/widgets/divider.dart';
import 'router.dart';
import 'dart:developer';


import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatelessWidget
{

  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:[

          // const SizedBox(height: 65.0,),
          // const Image(image: AssetImage('images/bplogo.png'),
          // width:120.0,
          // height: 120.0,
          // alignment: Alignment.center,
          // ),

          const SizedBox(height:15.0,),
          const Text(
            "Ingreso de Usuarios",
            style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),

            textAlign: TextAlign.center,
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 1.0,),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 20.0),
                ),

                const SizedBox(height: 1.0,),
                TextField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 1.0,),
                ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20, color: Colors.white))),
                onPressed: () {
                  if(!emailTextEditingController.text.contains("@"))
                  {
                    displayToastMessage("email address is not Valid.");
                  }
                  else if(passwordTextEditingController.text.length<7)
                  {
                    displayToastMessage("password must be atleast 6 characters.");
                  }
                  else
                  {
                    loginAndAuthenticateUser(context);
                  }
                  
                },
                child: const Text('Enabled Button')),
            const SizedBox(height: 20),
            
            ],
            ),
              
          ),
        TextButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
          }, 
          child: const Text(
            "Do not have an account? Register here. ",
          ),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
          return ProgessDialog(message: "authenticating, please wait..");

      }
    );
    final User? firebaseUser  = (await _firebaseAuth.signInWithEmailAndPassword(
    email: emailTextEditingController.text,
    password: passwordTextEditingController.text
  ).catchError((errMsg)

  {
    Navigator.pop(context);
    displayToastMessage(errMsg.toString());

  })).user;
  if(firebaseUser != null) 
  {
    usersRef.child(firebaseUser.uid).once().then((DatabaseEvent snap){
      if(snap.snapshot.value != null)
      {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);;
        displayToastMessage("You are logged in now. ");
      }
      else
      {
        Navigator.pop(context); 
        _firebaseAuth.signOut();
        displayToastMessage("No record exists for this user, please create a new account. ");
      }
    });
  
  }
else
{
  Navigator.pop(context);
  displayToastMessage("Error Ocurred, can not Sign in.");
}
  }
  displayToastMessage(String message)
  {
  Fluttertoast.showToast(msg: message);
  }
}