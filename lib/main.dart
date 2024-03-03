import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paypie_project/firebase_options.dart';
import 'package:paypie_project/models/user_model.dart';
import 'package:paypie_project/screens/profile_screen.dart';
import 'package:paypie_project/screens/sign_up_screen.dart';
import 'package:paypie_project/services/auth_service.dart';
import 'package:paypie_project/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserService()), // Add your provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'PayPie Intern Assessment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();

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
        } else {
          // If user data is available, check if the user has a name
          final userModel = snapshot.data;

          if (userModel != null && userModel.name != null) {
            // User has a name, navigate to the profile page
            return const ProfilePage1();
          } else {
            // User does not have a name, navigate to the sign-up page
            return const SignUpPage1();
          }
        }
      },
    );
  }
}
