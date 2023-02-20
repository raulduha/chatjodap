import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/provider/facebook_sign_in.dart';
import 'package:flutter_application_1/screens/forgot_pw_page.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'registrationScreen.dart';
import 'package:flutter_application_1/widgets/progressDiaalog.dart';
import 'package:division/division.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget
{

  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context){
    
    return WillPopScope(
      onWillPop: () async => false,
      
      child:Scaffold(
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const SizedBox(height: 80,),

          // Imagen Logo?

          // const SizedBox(height: 65.0,),
          // const Image(image: AssetImage('images/bplogo.png'),
          // width:120.0,
          // height: 120.0,
          // alignment: Alignment.center,
          // ),

          const SizedBox(height: 20),
          Container(
  child: Image.asset('images/jodap_image.png',
  height: 100,
  width: 200,
  fit: BoxFit.cover)
),
          /** 
          Image.asset(
              'images/evnt1.png',
              height: 100,
              width: 300,
              fit: BoxFit.cover,),
          */
          const SizedBox(height: 25),
          const Text(
            "Welcome Back!",
            style: TextStyle(fontSize: 20, fontFamily: "Brand Bold", color: Colors.white),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Email Field

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
                        controller: emailTextEditingController,
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


                // Password Field

                const SizedBox(height: 10),
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
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          icon: Icon(Icons.lock, color: Colors.grey,),
                        ),
                      ),
                    ),
                    ),
                ),


                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPasswordPage();
                            },
                          ),
                        );
                      }, 
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),                  ),
                ),


                // SignIn button
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(350, 45)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF993A84)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),

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

                      child: const Text("Sign in"),
                    ),
                  ),
                ),



                const SizedBox(height: 15),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child:
                    Row(
                        
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                                child: Divider(
                                    color: Colors.grey[800],
                                    thickness: 4,
                                ),
                            ),
                            SizedBox(width: 8),
                            Text("OR", style: TextStyle(color: Colors.white),),
                            SizedBox(width: 8),
                            Expanded(
                                child: Divider(
                                    color: Colors.grey[800],
                                    thickness: 4,
                                ),
                            ),
                        ],
                    ),
                ),




                // Google Login

                const SizedBox(height: 15),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin(context);
                  },
                ),


                // Facebook Login
                const SizedBox(height: 15,),
                SignInButton(
                  Buttons.FacebookNew,
                  text: "Continue with Facebook",
                  onPressed: () {
                    print("tapped FBLOGIN");
                    final provider = Provider.of<FacebookSignInProvider>(context, listen: false);
                    provider.facebookLogin(context);
                  },
                ),



              ],
            ),
          ),


          const SizedBox(height: 15),
          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Do not have an account?",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    TextButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                      }, 
                      child: const Text(
                        "Sign Up here",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF993A84)),
                      ),
                    ),
                  ],
          )


        ],
      ),
    ));
  }




  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
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
    
    if(firebaseUser != null) {
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
    else {
      Navigator.pop(context);
      displayToastMessage("Error Ocurred, can not Sign in.");
    }
  }






  displayToastMessage(String message)
  {
  Fluttertoast.showToast(msg: message);
  }
}