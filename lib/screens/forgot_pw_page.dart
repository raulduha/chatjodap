import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailTextEditingController = TextEditingController();


  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextEditingController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password reset link set! Check your email"),
          );
        },
      );


    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[200],
        elevation: 0
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Enter your Email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'Brand Bold', color: Colors.white),
            ),
          ),



          // Email Field

          const SizedBox(height: 25,),
          Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                    controller: _emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    icon: Icon(Icons.email, color: Colors.grey,),
                  ),
                ),
              ),
            ),
          ),


          const SizedBox(height: 20),
          MaterialButton(

            onPressed: () {
              passwordReset();
            },
            color: Colors.deepPurpleAccent[200],
            child: const Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),

          )






        ]
      ),
    );
  }
}