// registration_screen.dart
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/loginScreen.dart';
import 'package:flutter_application_1/profile_pages/edit_profile.dart';
import 'package:flutter_application_1/profile_pages/friends_page.dart';
import 'package:flutter_application_1/profile_pages/history.dart';
import 'package:flutter_application_1/profile_pages/privacy.dart';
import 'package:flutter_application_1/profile_pages/tutorial.dart';
import 'package:flutter_application_1/widgets/alert_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shadow_overlay/shadow_overlay.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:flutter_application_1/profile_pages/eventFAQ.dart';
import 'package:flutter_application_1/profile_pages/reportBug.dart';
import 'package:flutter_application_1/profile_pages/inviteFriend.dart';
import 'package:flutter_application_1/profile_pages/terms.dart';



class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  double circleTopPosition = -150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 39, 1),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Purple Circle
          Positioned(
            top: circleTopPosition, // Use a dynamic value for top position
            left: (MediaQuery.of(context).size.width - 400) / 2,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF993A84),
              ),
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                setState(() {
                  // Update the top position of the circle based on the scroll offset
                  circleTopPosition -= notification.scrollDelta!;
                });
              }
              return true;
            },
            child: SingleChildScrollView(
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

                            String? photoURL = userData['photoURL'];

                            return Column(
                              children: [
                                const SizedBox(height: 100),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: photoURL != null
                                            ? Image.network(photoURL, fit: BoxFit.cover)
                                            : const Image(
                                                image: AssetImage("images/empty_profile.png"),
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                      userData['username'],
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Brand Bold",
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
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
                                label: "Tu historial",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Friends page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FriendsPage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.group_sharp,
                                label: "Amigos",
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
                                label: "Editar Perfil",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Privacy page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrivacyPage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.lock,
                                label: "Privacidad",
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
                                // Navigate to Report Bug page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportBugPage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.bug_report,
                                label: "Reporta un bug",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Invite Friend page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InviteFriendPage(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.person_add,
                                label: "Invita un amigo",
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Event FAQ page
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
                                // Navigate to Terms and Conditions page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TermsAndConditions(),
                                  ),
                                );
                              },
                              child: _buildProfileItem(
                                icon: Icons.description,
                                label: "Terminos y condiciones",
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () async {
                                final action = await AlertDialogsInteractive.yesCancelDialog(
                                  context,
                                  'Cerrar sesion',
                                  'Estas seguro?',
                                  'Cancelar',
                                  'Si',
                                  Colors.redAccent[400],
                                );
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
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Cerrar sesion",
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
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(28, 27, 27, 1),
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
  })]),
              ),
            ),
          
        ],
      ),
    );
  }
}

  Widget _buildProfileItem({required IconData icon, required String label}) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color.fromARGB(255, 181, 181, 181), width: 1)),
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

