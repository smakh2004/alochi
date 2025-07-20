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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/animations/MrSquareStreak.json',
                        height: 250,
                        width: 240,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/Lightining.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      S.of(context).davomiyYutuq,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: primaryPurple,
                        fontFamily: primaryFont,
                      ),
                    ),
                    Text(
                      S.of(context).sizniErtagaKutamiz,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: AnimatedButton(
                height: 50,
                width: 310,
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
            ),
          ],
        ),
      ),
    );
  }
}
