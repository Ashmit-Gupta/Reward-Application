import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reward_app/utils/routes/routes_name.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkAuthentication(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      User? user = _auth.currentUser;
      if (user == null) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    });
  }
}
