import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:flutter_application_1/profile_pages/terms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'loginScreen.dart';
import 'screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_application_1/widgets/progressDiaalog.dart';
import 'package:flutter_application_1/widgets/divider.dart';
import 'package:division/division.dart';
import 'router.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';



class RegistrationScreen extends StatelessWidget 
{

  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController repeatpasswordTextEditingController = TextEditingController();
  bool termsChecked = false;

  // ignore: non_constant_identifier_names
  bool minim_age = true;
  TextEditingController dateTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[

          const SizedBox(height: 50),

          // imagen Logo?

          // const SizedBox(height: 1.0,),
          // const Image(image: AssetImage('images/bplogo.png'),
          // width:100.0,
          // height: 100.0,
          // alignment: Alignment.center,
          // ),

          const Text(
            "Registrarse!",
            style: TextStyle(fontSize: 30.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),
          const Text(
            "Los mejores eventos te esperan!",
            style: TextStyle(fontSize: 20, fontFamily: "Brand Bold", color: Colors.white),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [



                // Name

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
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre',
                          icon: Icon(Icons.person, color: Colors.grey,),
                        ),
                      ),
                    ),
                  )
                ),

                // Last Name

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
                        controller: lastnameTextEditingController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Apellido(s)',
                          icon: Icon(Icons.person, color: Colors.grey,),
                        ),
                      ),
                    ),
                  )
                ),

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
                        controller: usernameTextEditingController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre de Usuario',
                          icon: Icon(Icons.person, color: Colors.grey,),
                        ),
                      ),
                    ),
                  )
                ),


                // Email


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


                // Birth Date

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
                        controller: dateTextEditingController,
                        onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1930), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF993A84), // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Color(0xFF993A84), // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF993A84)// button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            
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
                              else {
                                minim_age = true;
                              }
                          }
                        },

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Fecha de nacimiento',
                          icon: Icon(Icons.calendar_month, color: Colors.grey,),
                        ),
                      ),
                    ),
                  )
                ),



                 // Password

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
                          hintText: 'Contraseña',
                          icon: Icon(Icons.lock, color: Colors.grey,),
                        ),
                      ),
                    ),
                    ),
                ),

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
                        controller: repeatpasswordTextEditingController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Repite la contraseña',
                          icon: Icon(Icons.lock, color: Colors.grey,),
                        ),
                      ),
                    ),
                    ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Aceptas los",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TermsAndConditions()),
                        );
                      }, 
                      child: const Text(
                        "Términos y condiciones",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF993A84)),
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: ElevatedButton(

                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(310, 45)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF993A84)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),

                      onPressed: () async {
                        if(nameTextEditingController.text.length < 3)
                        {
                          displayToastMessage("El Nombre debe tener al menos 3 caracteres.");
                        }
                        else if(usernameTextEditingController.text.length < 2)
                        {
                          displayToastMessage("El Nombre de Usuario debe tener al menos caracteres.");
                        }
                        else if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("El Email no es valido.");
                        }
                        else if(passwordTextEditingController.text.length<6)
                        {
                          displayToastMessage("La contraseña debe tener mas de 6 caracteres.");
                        }
                        else if (minim_age == false) {
                          displayToastMessage("Debes tener +18 de edad para registrarte");
                        }
                        else if (passwordTextEditingController.text != repeatpasswordTextEditingController.text) {
                          displayToastMessage("Las contraseñas deben coincidir");
                        }
                        else if (await checkIfEmailExists(emailTextEditingController.text)) {
                          displayToastMessage("Email ya está en uso");
                        }
                        else if (await checkIfUsernameExists(usernameTextEditingController.text)) {
                          displayToastMessage("Nombre de usuario ya está en uso");
                        }
                        else {
                          registerNewUser(context);
                        }
                      },
                      child: const Text('Registrarse')),
                  ),
                ),




                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Ya tienes una cuenta?",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    TextButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                      }, 
                      child: const Text(
                        "Iniciar sesión aqui",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF993A84)),
                      ),
                    ),
                  ],
                )



            ],
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
          return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xFF993A84),)));
      }
    );

    final User? firebaseUser  = (await _firebaseAuth.createUserWithEmailAndPassword(
    email: emailTextEditingController.text,
    password: passwordTextEditingController.text,
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
      "username": usernameTextEditingController.text.trim(),
      "friends": [], // initialize an empty list for friends
      "friendsReq": [],
      
    };
    usersRef.child(firebaseUser.uid).set(userDataMap);
    displayToastMessage("Felicidades, tu cuenta ha sido creada.");

    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  }
  else
  {
    Navigator.pop(context);
    displayToastMessage("La cuenta no ha podido ser creada");
  }

  }
  displayToastMessage(String message)
  {
  Fluttertoast.showToast(msg: message);
  }


  Future<bool> checkIfEmailExists(String email) async {
    final query = FirebaseDatabase.instance.ref().child('users').orderByChild('email').equalTo(email);
    final DatabaseEvent event = await query.once();
    print(event.snapshot);
    if (event.snapshot.exists) {
      print(true);
      return true;
    }
    else {
      print(false);
      return false;
    }
    
  }

  Future<bool> checkIfUsernameExists(String username) async {
    final query = FirebaseDatabase.instance.ref().child('users').orderByChild('username').equalTo(username);
    final DatabaseEvent event = await query.once();
    print(event.snapshot);
    if (event.snapshot.exists) {
      print(true);
      return true;
    }
    else {
      print(false);
      return false;
    }
    
  }




}