import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paypie_project/models/user_model.dart';
import 'package:paypie_project/screens/create_user_profile_screen.dart';
import 'package:paypie_project/services/user_service.dart';
import 'package:provider/provider.dart';

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();
    final signout = userService.signOut(context);

    return FutureBuilder<UserModel?>(
      future:
          userService.fetchUserProfile(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If an error occurred while fetching data, display an error message
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          // If no user data is available, display a message
          return Text('No user data found');
        } else {
          // If user data is available, display the profile information
          UserModel user = snapshot.data!;
          return Scaffold(
            body: Container(
              color: Colors.white54,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const ListTile(
                    leading: Icon(Icons.arrow_back),
                    trailing: Icon(Icons.menu),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 26),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(user.email)],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.bio,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Expanded(
                        child: ListView(
                      children: [
                        Card(
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserProfileScreen()));
                            },
                            child: const ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: GestureDetector(
                            onTap: () {
                              signout;
                            },
                            child: const ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
