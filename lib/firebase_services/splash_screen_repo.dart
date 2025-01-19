import 'dart:async';

import 'package:bhi/pages/auth/login_screen.dart';
import 'package:bhi/pages/home/dashboard.dart';
import 'package:bhi/pages/onboarding/intro_screen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenRepo {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => OnboardingScreen())));
    }
  }
}
