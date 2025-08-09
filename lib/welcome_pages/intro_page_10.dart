import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/generated/l10n.dart'; // l10n import

class IntroPage10 extends StatefulWidget {
  final PageController controller;

  const IntroPage10({super.key, required this.controller});

  @override
  State<IntroPage10> createState() => _IntroPage10State();
}

class _IntroPage10State extends State<IntroPage10> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Content (Animation + Text in Column)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animation
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      child: Lottie.asset(
                        'assets/animations/Intro7.json',
                        repeat: true,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Main Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        S.of(context).personalizedLearningPath, // localized
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font,
                          fontSize: 25,
                          color: questionColor,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Create Profile Button
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnimatedButton(
                height: 50,
                width: size.width * 0.8,
                duration: 100,
                shadowDegree: ShadowDegree.light,
                borderRadius: 16,
                color: primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckPage()),
                  );
                },
                child: Text(
                  S.of(context).createFreeProfile, // localized
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: Font,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Try a lesson text
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                S.of(context).tryALesson, // localized
                style: TextStyle(
                  fontFamily: Font,
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
