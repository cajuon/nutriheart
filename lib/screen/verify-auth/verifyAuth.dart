import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:nutriheart/screen/screen.dart';

class verifyAuth extends StatelessWidget {
  static String routeName = '/verifyAuth';
  const verifyAuth({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Nav();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SignInScreen(
              providerConfigs: [EmailProviderConfiguration()],
              subtitleBuilder: (context, action) => Padding(
                    padding: EdgeInsets.only(bottom: 22),
                    child: Text(action == AuthAction.signIn
                        ? 'Welcome to Nutriheart! Please sign in to continue'
                        : 'Welcome to Nutriheart! Please create an account to continue'),
                  ),
              footerBuilder: (context, _) => const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Nutriheart is a group project for MAD CSCI 4311',
                    style: TextStyle(color: Colors.grey),
                  )));
        }
      });
}
