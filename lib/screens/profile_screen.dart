// registration_screen.dart
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/loginScreen.dart';
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
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                        Map<dynamic, dynamic> userData =
                            snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

                        return Column(
                          children: [
                            Stack(
                              children: [
                                ShadowOverlay(
                                  shadowWidth: 400,
                                  shadowHeight: 250,
                                  shadowColor: Colors.black,
                                  child: Image.asset(
                                    'images/profileparty.png',
                                    height: 250,
                                    width: 400,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 175,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userData['name'],
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              fontFamily: "Brand Bold",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          userData['lastname'],
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              fontFamily: "Brand Bold",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      userData['email'],
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Brand Bold",
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to History page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HistoryPage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.history,
                                label: "History",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Edit Profile page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.edit,
                                label: "Edit Profile",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Tutorial page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TutorialPage(),
                                    ),
                                  );
                                },
                              child: _buildProfileItem(
                                icon: Icons.help_outline,
                                label: "Tutorial",
  
                                ),
                              ),
                              const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Tutorial page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportBugPage(),
                                    ),
                                  );
                                },
                              child: _buildProfileItem(
                                icon: Icons.bug_report,
                                label: "report a bug",
  
                                ),
                              ),
                              const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Tutorial page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InviteFriendPage(),
                                    ),
                                  );
                                },
                              child: _buildProfileItem(
                                icon: Icons.person_add,
                                label: "Invite a Friend",
  
                                ),
                              ),
                              const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Tutorial page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventFAQPage(),
                                    ),
                                  );
                                },
                              child: _buildProfileItem(
                                icon: Icons.question_answer,
                                label: "Jodap FAQ",
  
                                ),
                              ),
                              const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Tutorial page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TermsAndConditions(),
                                    ),
                                  );
                                },
                              child: _buildProfileItem(
                                icon: Icons.description,
                                label: "Terms & Conditions",
  
                                ),
                              ),

                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                final action = await AlertDialogsInteractive.yesCancelDialog(context, 'Logout', 'Are you Sure?', 'Cancel', 'Yes', Colors.redAccent[400]);
                                if (action == DialogsAction.yes) {
                                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                  provider.googleLogout(context);
                                }
                              },
                              splashColor: Colors.white,
                                  
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              color: Colors.redAccent[200],
                                              size: 28,
                                            ),
                                            const SizedBox(width: 08),
                                            const Text(
                                              "Logout",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      
                                    ],
                                  ),
                                
                              ),
                            
                            const SizedBox(height: 30),

],
);
} else if (snapshot.hasError) {
return const Text("Error fetching user data");
} else {
return  Center(
  // ACA EL CIRCULAR NOSE PQ APARECE MUY ARRIBA ENTONCES LO PUSE INVISible. el color seria Color(0xFF993A84)
child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(28, 27, 27, 1),),
            
          ),
);
}
},
);
}
return const SizedBox.shrink();

},
),
],
),
),
);
}
Widget _buildProfileItem({required IconData icon, required String label}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromRGBO(36, 36, 39, 1),
      border: Border.all(
        color: Color.fromRGBO(36, 36, 39, 1),
        width: 2,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
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
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 30,
        ),
      ],
    ),
  );
}
}


class ShadowOverlay extends StatelessWidget {
  final double shadowWidth;
  final double shadowHeight;
  final Color shadowColor;
  final Widget child;

  const ShadowOverlay({
    Key? key,
    required this.shadowWidth,
    required this.shadowHeight,
    required this.shadowColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromRGBO(28, 27, 27,1),
        
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 0,
            blurRadius: 50,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        child: child,
      ),
    );
  }
}