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
import 'package:shared_preferences/shared_preferences.dart';

class LoserPage extends StatefulWidget {
  const LoserPage({super.key});

  @override
  State<LoserPage> createState() => _LoserPageState();
}

class _LoserPageState extends State<LoserPage> {
  @override
  void initState() {
    super.initState();
    _handleHeartDecrement();
  }

  Future<void> _handleHeartDecrement() async {
    // 💔 Decrease hearts immediately
    if (GameState.hearts > 0) {
      GameState.hearts -= 1;
    }

    // ⏳ If hearts reach 0, start the regen timer
    if (GameState.hearts == 0) {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now().millisecondsSinceEpoch;
      await prefs.setInt('heartDepletedTime', now);
    }

    // 💾 Save to Firestore
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await GameState.saveState(userId);
    }
  }

  Future<bool> _handleBackButton() async {
    // ✅ Override system back button to go to BoshlangichSinf
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BoshlangichSinf()),
    );
    return false; // prevent default pop
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackButton, // handle phone back button
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/MrSquareIncorrect.json',
                        height: 250,
                        width: 240,
                      ),
                      Image.asset(
                        'assets/icons/Heart.png',
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        S.of(context).joningiztugadi,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: red,
                          fontFamily: BoldFont,
                        ),
                      ),
                      Text(
                        S.of(context).tanafuzQilib,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font,
                          fontSize: 18,
                          color: buttonRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom button
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedButton(
                  height: 50,
                  width: 310,
                  color: buttonWrong,
                  onPressed: () {
                    Navigator.pop(context, 'lostHeart');
                  },
                  child: Text(
                    S.of(context).uygaQaytish,
                    style: const TextStyle(
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
