import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutria/src/screen/login/sign_in_page.dart';
import 'package:nutria/src/settings/settings_view.dart';

import 'fitness_app_home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      print(user);
      if (user != null) {
        Navigator.pushNamed(context, FitnessAppHomeScreen.routeName);
      } else {
        Navigator.pushNamed(context, SignInPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nutria'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Center(
          child: MaterialButton(
              child: Text('Fitness'),
              onPressed: () {
                // Navigator.restorablePushNamed(context, FitnessAppHomeScreen.routeName);
                Navigator.restorablePushNamed(context, SignInPage.routeName);
              }),
        ),
      ),
    );
  }
}
