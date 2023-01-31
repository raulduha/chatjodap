import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatelessWidget {

  static const String idScreen = "edit-profile";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[200],
        title: const Text(
          "Edit Profile",
        ),
        centerTitle: true,
      ),
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            "Edit your data if you want to",
            style: TextStyle(fontSize: 25.5, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50,),

          // Name

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
          ),


          const SizedBox(height: 50,),


          // Last Name

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: lastnameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Last Name',
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
          ),

          const SizedBox(height: 50),

          Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: ElevatedButton(

                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(350, 45)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),

                      onPressed: () async {
                        if(nameTextEditingController.text.length < 3)
                        {
                          displayToastMessage("Name must be atleast 3 characters.");
                        }
                        else if(nameTextEditingController.text.length > 10)
                        {
                          displayToastMessage("Name must be max. 10 characters.");
                        }
                        else if(lastnameTextEditingController.text.length < 3)
                        {
                          displayToastMessage("Lastname must be atleast 3 characters.");
                        }
                        else if(lastnameTextEditingController.text.length > 10)
                        {
                          displayToastMessage("Lastname must be max. 10 characters.");
                        }


                        // Más validaciones



                        else {
                          updateUserData(context);
                        }
                      },
                      child: const Text('Update')),
                  ),
          ),


        ],
      ),
    );
  }








  displayToastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  updateUserData(BuildContext context) async {
    final User user = _auth.currentUser!;
    final String uid = user.uid;

    Map<String, dynamic> newData = {
      "name": nameTextEditingController.text.trim(),
      "lastname": lastnameTextEditingController.text.trim(),
    };

    try {
      await _database.ref().child('users').child(uid).update(newData);
    } catch (e) {
      displayToastMessage(e.toString());
    }

  }


}

