import 'package:flutter/material.dart';
import 'main.dart';
import 'loginScreen.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/widgets/progressDiaalog.dart';
import 'package:flutter_application_1/widgets/divider.dart';
import 'router.dart';
class RegistrationScreen extends StatelessWidget 
{
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:[
          const SizedBox(height: 15.0,),
          const Image(image: AssetImage('images/bplogo.png'),
          width:100.0,
          height: 100.0,
          alignment: Alignment.center,

          ),
          const SizedBox(height:15.0,),
          const Text(
            "Registro de Usuarios",
            style: TextStyle(fontSize: 14.0, fontFamily: "Brand Bold"),

            textAlign: TextAlign.center,
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [

                const SizedBox(height: 1.0,),
                TextField(
                  controller: nameTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 20.0),
                ),

                const SizedBox(height: 10.0,),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 10.0),
                ),

                const SizedBox(height: 1.0,),
                TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 10.0),
                ),

                const SizedBox(height: 1.0,),
                TextField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: TextStyle(fontSize: 10.0),
                ),
                const SizedBox(height: 1.0,),
                ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 10, color: Colors.white))),
                onPressed: () 
                {
                  if(nameTextEditingController.text.length < 4)
                  {
                    displayToastMessage("name must be atleast 3 characters.");
                  }
                  else if(!emailTextEditingController.text.contains("@"))
                  {
                    displayToastMessage("email address is not Valid.");
                  }
                  else if(phoneTextEditingController.text.isEmpty)
                  {
                    displayToastMessage("Phone number is mandatory.");
                  }
                  else if(passwordTextEditingController.text.length<7)
                  {
                    displayToastMessage("password must be atleast 6 characters.");
                  }
                  
                  registerNewUser(context);
                },
                child: const Text('Enabled Button')),
                  const SizedBox(height: 10),
            
            ],
            ),
              
          ),
        TextButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
          }, 
          child: const Text(
            "already have an account? login here. ",
          ),
          ),
        ],
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
          return ProgessDialog(message: "Registering, please wait..");

      }
    );

    final User? firebaseUser  = (await _firebaseAuth.createUserWithEmailAndPassword(
    email: emailTextEditingController.text,
    password: passwordTextEditingController.text
  ).catchError((errMsg)
  {
    Navigator.pop(context);
    displayToastMessage(errMsg.toString());

  })).user;
  
  if(firebaseUser != null) 
  {
    
    Map userDataMap = {
      "name": nameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": phoneTextEditingController.text.trim(),
    };
    usersRef.child(firebaseUser.uid).set(userDataMap);
    displayToastMessage("Congratulations, yout account has been created.");

    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  }
  else
  {
    Navigator.pop(context);
    displayToastMessage("New user account has not been Created");
  }

  }
  displayToastMessage(String message)
  {
  Fluttertoast.showToast(msg: message);
  }
}