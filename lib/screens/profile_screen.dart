// registration_screen.dart
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/profile_pages/edit_profile.dart';
import 'package:flutter_application_1/profile_pages/history.dart';
import 'package:flutter_application_1/profile_pages/tutorial.dart';
import 'package:flutter_application_1/widgets/alert_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:shadow_overlay/shadow_overlay.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:flutter_application_1/eventFAQ.dart';
import 'package:flutter_application_1/reportBug.dart';
import 'package:flutter_application_1/inviteFriend.dart';
import 'package:flutter_application_1/terms.dart';



class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

@override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: rgb(28, 27, 27),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: 
        Column (

          children: [

            StreamBuilder<User?>(
              stream: _auth.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  return StreamBuilder(
                    stream: _database
                        .ref()
                        .child('users')
                        .child(user?.uid ?? '')
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data?.snapshot.value != null) {
                        Map<dynamic, dynamic> userData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;
                        
                        return Column(
                          children: <Widget>[

                            Stack(
                              
                              children: <Widget>[

                                ShadowOverlay(
                                  shadowWidth: 400,
                                  shadowHeight: 250,
                                  shadowColor: Colors.black,
                                  child:
                                    Image.asset(
                                      'images/profileparty.png',
                                      height: 250,
                                      width: 400,
                                      fit: BoxFit.cover,
                                      
                                    ),
                                  
                                ),


                                Column(

                                  children: [

                                    const SizedBox(height: 180,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userData['name'],
                                          style: const TextStyle(fontSize: 30.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
                                        ),

                                        const SizedBox(width: 10),
                                        Text(
                                          userData['lastname'],
                                          style: const TextStyle(fontSize: 30.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),
                                    Text(
                                          userData['email'],
                                          style: const TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", color: Colors.white, fontWeight: FontWeight.normal),
                                    ),

                                  ],

                                ),
                                
                              ],
                            ),

                            
                            const Divider(
                              // color: Colors.deepPurpleAccent[200],
                              color: Colors.white38,
                              thickness: 4,
                            ),
                            const SizedBox(height: 10,),



                            // HISTORY

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [

                                  InkWell(
                                    
                                    onTap: () {
                                      print("tapped History");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HistoryPage()),
                                      );
                                    },

                                    splashColor: Colors.white,

                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.history,
                                                color: Colors.purple,
                                                size: 28,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "History",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ],
                                                  
                                          ),

                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                  ),
                                ],
                              ),
                            ),



                            // EDIT PROFILE, NOTIFICATIONS AND LANGUAGE

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [


                                  InkWell(
                                
                                    onTap: () {
                                      print("tapped Edit Profile");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditProfilePage()),
                                      );
                                    },

                                    splashColor: Colors.white,

                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.settings,
                                                color: Colors.purple,
                                                size: 28,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "Edit Profile",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ],
                                                  
                                          ),

                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                  ),


                                  const SizedBox(height: 15,),
                                  InkWell(
                                    
                                    onTap: () {
                                      print("tapped Notifications");
                                    },

                                    splashColor: Colors.white,

                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.notifications_on,
                                                color: Colors.purple,
                                                size: 28,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Notifications",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ],
                                                  
                                          ),

                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                  ),

                                ],
                              ),
                            ),






                            // TUTORIAL, FAQ, REPORT A BUG

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [


                                  InkWell(
                                
                                    onTap: () {
                                      print("tapped Edit TUtorial");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TutorialPage(),
                                        ),
                                      );
                                    },

                                    splashColor: Colors.white,

                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.live_help_rounded,
                                                color: Colors.purple,
                                                size: 28,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Tutorial",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ],
                                                  
                                          ),

                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                  ),


                                  const SizedBox(height: 15,),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventFAQPage(),
                                        ),
                                      );
                                    },
                                    splashColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.question_answer_rounded,
                                              color: Colors.purple,
                                              size: 28,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Jodap FAQ",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),


                                  const SizedBox(height: 15,),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ReportBugPage(),
                                        ),
                                      );
                                    },

                                    splashColor: Colors.white,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.report_problem,
                                              color: Colors.purple,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Report a Bug",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ],
                                        ),

                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),




                            // INVITE A FRIEND

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [

                                  InkWell(
                                    onTap: () {
                                      print("tapped INVITE");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InviteFriendPage(),
                                        ),
                                      );
                                    },
                                    splashColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_add,
                                              color: Colors.purple,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Invite a Friend",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),




                            // TERMS AND CONDITIONS

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("tapped TERMS");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TermsAndConditions(),
                                        ),
                                      );
                                    },
                                    splashColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.handshake,
                                              color: Colors.purple,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Terms and conditions",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),


                            // LOGOUT

                            Padding(
                              
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [

                                  InkWell(
                                    
                                    onTap: () async {
                                      final action = await AlertDialogsInteractive.yesCancelDialog(context, 'Logout', 'Are you Sure?', 'Cancel', 'Yes', Colors.redAccent[400]);
                                      if (action == DialogsAction.yes) {
                                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                        provider.googleLogout(context);
                                      }
                                    },

                                    splashColor: Colors.white,

                                    child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color: Colors.redAccent[200],
                                                size: 28,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Logout",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ],
                                                  
                                          ),

                                          
                                        ],
                                      ),
                                  ),

                                ],
                              ),
                            ),








                          // aca en vola logo con color??






                          ],
                        );
                      } else {
                        return Container(
                            width: 500,
                            height: 500,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Container(
                            width: 500,
                            height: 500,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                          ),
                        );
                      }
              },
            ),
          ],
        ),
      ),
    );
  }
}




