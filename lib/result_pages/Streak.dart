// ignore_for_file: file_names

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class Streak extends StatefulWidget {
  const Streak({super.key});

  @override
  State<Streak> createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/animations/MrSquareStreak.json',
                height: 290,
                width: 280,
              ),
            ),
            Image.asset(
              'assets/icons/Lightining.png',
              height: 70,
              width: 70,
            ),
            Text(
              S.of(context).davomiyYutuq,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: primaryPurple,
                fontFamily: primaryFont,
              ),
            ),
            Text(
              S.of(context).sizniErtagaKutamiz,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: primaryPurple,
              ),
            ),
            SizedBox(height: 30),
            AnimatedButton(
              height: 50,
              width: 150,
              color: primaryPurple,
              onPressed: () {
                Navigator.pop(context, 'xpGained');
              },
              child: Text(
                S.of(context).uygaQaytish,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
