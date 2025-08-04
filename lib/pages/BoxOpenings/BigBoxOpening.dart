import 'dart:math';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class BigBoxOpening extends StatefulWidget {
  const BigBoxOpening({super.key});

  @override
  State<BigBoxOpening> createState() => _BigBoxOpeningState();
}

class _BigBoxOpeningState extends State<BigBoxOpening> {
  bool showSecondAnimation = false;
  bool showText = false;
  late int earnedGems;
  late String gemsOrFreeze;

  @override
  void initState() {
    super.initState();

    bool freezerAvailable = GameState.activeFreezes < 2;
    bool giveFreeze = freezerAvailable && Random().nextBool();

    List<int> gemValues;

    if (giveFreeze) {
      gemsOrFreeze = 'freeze';
      GameState.activeFreezes += 1;
      gemValues = [10, 20, 40];
    } else {
      // Determine eligibility for storm and heart
      bool canDropStorm = GameState.mathStormAttemptsLeft < 3;
      bool canDropHeart = GameState.hearts < 5;

      List<String> possibleDrops = [];

      if (canDropStorm) possibleDrops.add('storm');
      if (canDropHeart) possibleDrops.add('heart');

      // If neither storm nor heart can drop, default to gems
      if (possibleDrops.isEmpty) {
        gemsOrFreeze = 'gems';
        gemValues = [20, 20, 40, 40, 40, 100]; // weighted for fewer 100s
      } else {
        // Randomly pick one of the allowed extra types (storm or heart)
        gemsOrFreeze = possibleDrops[Random().nextInt(possibleDrops.length)];
        if (gemsOrFreeze == 'storm') {
          GameState.mathStormAttemptsLeft += 1;
        } else {
          GameState.hearts += 1;
        }

        gemValues = [20, 20, 40, 40, 40, 100];
      }
    }

    earnedGems = gemValues[Random().nextInt(gemValues.length)];

    // Delayed animation and text display
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
    String firstAnimation;
    String secondAnimation;

    // Determine animations based on gems, freeze, storm, or heart
    switch (gemsOrFreeze) {
      case 'gems':
        firstAnimation = 'assets/animations/BigBoxAnimationGems1.json';
        secondAnimation = 'assets/animations/BigBoxAnimationGems2.json';
        break;
      case 'freeze':
        firstAnimation = 'assets/animations/BigBoxAnimationFreeze1.json';
        secondAnimation = 'assets/animations/BigBoxAnimationFreeze2.json';
        break;
      case 'storm':
        firstAnimation = 'assets/animations/BigBoxAnimationStorm1.json';
        secondAnimation = 'assets/animations/BigBoxAnimationStorm2.json';
        break;
      case 'heart':
        firstAnimation = 'assets/animations/BigBoxAnimationHeart1.json';
        secondAnimation = 'assets/animations/BigBoxAnimationHeart2.json';
        break;
      default:
        throw Exception('Unexpected gemsOrFreeze value: $gemsOrFreeze');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 11, right: 11),
            child: Column(
              children: [
                const SizedBox(height: 120),
            
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
            
                const SizedBox(height: 26),
            
                // Fade-in main reward text
                AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    gemsOrFreeze == 'gems'
                        ? '${S.of(context).youEarned} $earnedGems ${S.of(context).taOlmos}'
                        : gemsOrFreeze == 'freeze'
                            ? '${S.of(context).youGot} $earnedGems ${S.of(context).gemsAndFreezer}'
                            : gemsOrFreeze == 'storm'
                                ? '${S.of(context).youEarned} $earnedGems ${S.of(context).gemsAndStorm}'
                                : '${S.of(context).youEarned} $earnedGems ${S.of(context).gemsAndHeart}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor,
                      height: 1,
                    ),
                  ),
                ),
            
                const SizedBox(height: 14),
            
                // Fade-in subtext
                AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      gemsOrFreeze == 'gems'
                          ? S.of(context).keep
                          : gemsOrFreeze == 'freeze'
                              ? S.of(context).freezerSave
                              : gemsOrFreeze == 'storm'
                                  ? S.of(context).additionalMathStorm
                                  : S.of(context).additionalHeart,
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
                        if (gemsOrFreeze == 'gems' || gemsOrFreeze == 'freeze') {
                          GameState.gems += earnedGems;
                        } else if (gemsOrFreeze == 'storm') {
                          // No direct action needed for storm, handled in initState
                        } else if (gemsOrFreeze == 'heart') {
                          
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
