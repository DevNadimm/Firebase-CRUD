import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:firebase_crud/ui/home_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void isLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        ),
      );
    }
  }
}
