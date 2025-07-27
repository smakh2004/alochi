// ignore_for_file: file_names, use_build_context_synchronously

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void initState() {
    super.initState();

    // ✅ Increment lightning immediately when page is opened
    GameState.lightnings += 1;
    GameState.lastLightningDate = DateTime.now();

    // ✅ Save updated state immediately
    final user = FirebaseAuth.instance.currentUser;
    if (user?.uid != null) {
      GameState.saveState(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
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
                          fontFamily: BoldFont,
                        ),
                      ),
                      Text(
                        S.of(context).sizniErtagaKutamiz,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font,
                          fontSize: 18,
                          color: primaryPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedButton(
                  height: 50,
                  width: 310,
                  color: primaryPurple,
                  onPressed: () {
                    // ✅ Just navigate back to home now
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const BoshlangichSinf()),
                    );
                  },
                  child: Text(
                    S.of(context).uygaQaytish,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: Font,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

