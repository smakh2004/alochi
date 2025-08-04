import 'dart:math';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class BoxOpening extends StatefulWidget {
  const BoxOpening({super.key});

  @override
  State<BoxOpening> createState() => _BoxOpeningState();
}

class _BoxOpeningState extends State<BoxOpening> {
  bool showSecondAnimation = false;
  bool showText = false;
  late int earnedGems;
  late String gemsOrFreeze;

  @override
  void initState() {
    super.initState();

    bool freezerAvailable = GameState.activeFreezes < 2;
    double freezeProbability = 0.2;

    bool giveFreeze = freezerAvailable && Random().nextDouble() < freezeProbability;

    gemsOrFreeze = giveFreeze ? 'freeze' : 'gems';

    List<int> gemValues = giveFreeze ? [10, 20] : [10, 20, 50];
    earnedGems = gemValues[Random().nextInt(gemValues.length)];

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showSecondAnimation = true;
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              showText = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String firstAnimation = gemsOrFreeze == 'gems'
        ? 'assets/animations/BoxAnimation1.json'
        : 'assets/animations/BoxAnimationFreeze1.json';

    String secondAnimation = gemsOrFreeze == 'gems'
        ? 'assets/animations/BoxAnimation2.json'
        : 'assets/animations/BoxAnimationFreeze2.json';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 11, right: 11),
            child: Column(
              children: [
                const SizedBox(height: 140),
            
                // Animation switching
                SizedBox(
                  height: 340,
                  width: 340,
                  child: Lottie.asset(
                    showSecondAnimation ? secondAnimation : firstAnimation,
                    fit: BoxFit.contain,
                    repeat: showSecondAnimation,
                  ),
                ),
            
                // Fade-in main reward text
                AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    gemsOrFreeze == 'gems'
                        ? '${S.of(context).youEarned} $earnedGems ${S.of(context).taOlmos}'
                        : '${S.of(context).youEarned} $earnedGems ${S.of(context).gemsAndFreezer}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor,
                      height: 1,
                    ),
                  ),
                ),
            
                const SizedBox(height: 8),
            
                // Fade-in subtext
                AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      gemsOrFreeze == 'gems'
                          ? S.of(context).keep
                          : S.of(context).freezerSave,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Font,
                        fontSize: 19,
                        color: darkGrey,
                        height: 1,
                      ),
                    ),
                  ),
                ),
            
                const Spacer(),
            
                // Fade-in button only after text is shown
                AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: AnimatedButton(
                      width: 320,
                      height: 45,
                      borderRadius: 14,
                      color: primaryColor,
                      onPressed: () async {
                        if (gemsOrFreeze == 'gems') {
                          GameState.gems += earnedGems;
                        } else {
                          GameState.activeFreezes += 1;
                          GameState.gems += earnedGems;
                        }
            
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          await GameState.saveState(userId);
                        }
            
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        S.of(context).continueE,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Font,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
