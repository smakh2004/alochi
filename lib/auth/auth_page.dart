import 'package:alochi_math_app/registration/login/LoginPage.dart';
import 'package:alochi_math_app/registration/login/RegistrationPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
      if (showLoginPage) {
        return LoginPage(showRegisterPage: toggleScreens);
      } else {
        return RegistrationPage(showLoginPage: toggleScreens);
      }
  }
}