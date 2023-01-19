import 'dart:developer';
import 'package:flutter/material.dart';
import 'main.dart';
import 'loginScreen.dart';
import 'map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/widgets/progressDiaalog.dart';
import 'package:flutter_application_1/widgets/divider.dart';
import 'router.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';

class RegistrationScreen extends StatelessWidget 
{
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool minim_age = true;
  TextEditingController dateTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:[
          // const SizedBox(height: 1.0,),
          // const Image(image: AssetImage('images/bplogo.png'),
          // width:100.0,
          // height: 100.0,
          // alignment: Alignment.center,
          // ),

          const SizedBox(height:15.0,),
          const Text(
            "Regístrate!",
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

                const SizedBox(height: 1.0,),
                TextField(
                  controller: lastnameTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Last Name",
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
                TextField(
                  controller: dateTextEditingController, //editing controller of this TextField
                  decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Birth Date" //label text of field
                  ),
                  onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(1930), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now()
                  );

                    if(pickedDate != null ){
                        //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                        log(formattedDate); 
                        ////formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement
                        dateTextEditingController.text = formattedDate;

                        DateDuration age = AgeCalculator.age(pickedDate);
                        int ageInYears = age.years;
                        
                        if (ageInYears < 18) {
                          log("menor de edad");
                          minim_age = false;
                        }
                    }
                  }
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
                  else if (minim_age == false) {
                    displayToastMessage("You must be 18+ years to Join");
                  }
                  
                  else {
                    registerNewUser(context);
                  }
                  
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
      "lastname": lastnameTextEditingController.text.trim(),
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