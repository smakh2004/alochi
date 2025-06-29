// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/appear_once/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const StartPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'assets/animations/Logo.json',
              width: 1000,
              height: 1000,
            ),
          )
        ],
      ),
    );
  }
}