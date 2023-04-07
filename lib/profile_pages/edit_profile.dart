import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


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
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Row(
          children: [
            
            Container(
              child: Image.asset('images/edit_profile.png',
              height: 40,
              
              )
            ),
          ],
        ),
      ),
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          GestureDetector(
            onTap: () async {
              final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (imageFile != null) {
                final user = FirebaseAuth.instance.currentUser;
                final storageRef = FirebaseStorage.instance.ref().child('users/${user!.uid}/profile_picture.jpg');
                final uploadTask = storageRef.putFile(File(imageFile.path));
                final downloadUrl = await (await uploadTask).ref.getDownloadURL();
                displayToastMessage("Actualizando...");
                await user.updatePhotoURL(downloadUrl);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Foto de perfil actualizada de forma exitosa'),
                  behavior: SnackBarBehavior.floating,
                ));

                await _database
                  .ref()
                  .child('users')
                  .child(user.uid)
                  .update({'photoURL': downloadUrl});
                

              }
            },
            child: _buildEditProfileButton(icon: Icons.add_a_photo_outlined, label: "Cambiar Foto"),
          ),
          const SizedBox(height: 30,),

          GestureDetector(
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              final storageRef = FirebaseStorage.instance.ref().child('users/${user!.uid}/profile_picture.jpg');
              await storageRef.delete();
              await user.updatePhotoURL(null);

              displayToastMessage("Eliminando...");
              final databaseRef = FirebaseDatabase.instance.ref().child('users').child(user.uid).child('photoURL');
              await databaseRef.remove();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Foto de perfil eliminada de forma exitosa'),
                  behavior: SnackBarBehavior.floating,
                  
                ),
              );

            },
            child: _buildEditProfileButton(icon: Icons.delete_forever_outlined, label: "Eliminar Foto"),
          ),
          const SizedBox(height: 30,),

          const Text(
            "Edita tu Nombre (opcional)",
            style: TextStyle(fontSize: 25.5, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30,),

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
                      hintText: 'Nombre',
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
          ),


          const SizedBox(height: 30,),

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
                      hintText: 'Apellido(s)',
                      icon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
          ),

          const SizedBox(height: 30),

          GestureDetector(
            onTap: () async {
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
            child: _buildEditProfileButton(
              icon: Icons.edit_note,
              label: "Actualizar Nombre",
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

Widget _buildEditProfileButton({required IconData icon, required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    height: 50,
    width: 340,
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(15),
      color: Color.fromRGBO(36, 36, 39, 1),
      border: Border.all(
        color: Color.fromRGBO(36, 36, 39, 1),
        width: 2,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Color(0xFF993A84),
              size: 30,
            ),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


