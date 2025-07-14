// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/Student/Student.dart';
import 'package:alochi_math_app/pages/YuqoriSinf/YuqoriSinf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/appear_once/StartPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/generated/l10n.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartPage()),
      );
    } else {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CheckPage()),
        );
      } else {
        // ✅ LOAD state from Firestore
        await GameState.loadState(user.uid);

        final selectedLevel = GameState.selectedLevel;

        if (selectedLevel == S.of(context).boshlangich) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BoshlangichSinf()),
          );
        } else if (selectedLevel == S.of(context).yuqoriSinf) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => YuqoriSinf()),
          );
        } else if (selectedLevel == S.of(context).student) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Student()),
          );
        } else {
          // No level selected yet
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const StartPage()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Lottie.asset(
          'assets/animations/Logo.json',
          width: 1000,
          height: 1000,
        ),
      ),
    );
  }
}
