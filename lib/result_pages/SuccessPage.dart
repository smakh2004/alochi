// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/result_pages/Streak.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class SuccessPage extends StatefulWidget {
  final Duration duration; // Time taken to complete the task
  final int xp;            // XP gained
  final double accuracy;   // Accuracy percentage

  const SuccessPage({
    super.key,
    required this.duration,
    required this.accuracy,
    this.xp = 10,
  });

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late int currentXP;
  late int localScoreDop;

  @override
  void initState() {
    super.initState();
    // Initialize XP from widget
    currentXP = widget.xp;

    // Increment arifmetika
    GameState.arifmetika += GameState.arifmetikaDop;

    // Immediatelly initialize arifmetikaDop for next levels
    GameState.arifmetikaDop = 0;

    // Increment logika
    GameState.logika += GameState.logikaDop;

    // Immediatelly initialize logikaDop for next levels
    GameState.logikaDop = 0;

    // localScoreDop
    localScoreDop = GameState.scoreDop;

    // Score
    GameState.score += GameState.scoreDop;

    // Immediatelly initialize logikaDop for next levels
    GameState.scoreDop = 0;
  }

  @override
  Widget build(BuildContext context) {
    final minutes = widget.duration.inMinutes;
    final seconds = widget.duration.inSeconds % 60;

    // Get today's date
    final today = DateTime.now();

    // Check if lightning reward has already been claimed today
    bool alreadyClaimed = GameState.lastLightningDate != null &&
        GameState.lastLightningDate!.day == today.day &&
        GameState.lastLightningDate!.month == today.month &&
        GameState.lastLightningDate!.year == today.year;

    // Change button label based on reward claim status
    final buttonLabel = alreadyClaimed ? S.of(context).uygaQaytish : S.of(context).davomEtish;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation at top
            Center(
              child: Lottie.asset(
                'assets/animations/MrSquareCorrect.json',
                height: 290,
                width: 280,
              ),
            ),

            // Title text
            Text(
              S.of(context).ajoyibDars,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: primaryFont,
                color: buttonCorrect,
              ),
            ),

            const SizedBox(height: 20),

            // Stat blocks: XP, Time, Accuracy
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Score Stat
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: orange, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).ochko,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: orange, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            '$localScoreDop',
                            style: const TextStyle(
                              fontSize: 18,
                              color: orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                // Time Stat
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).vaqt,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, color: primaryColor, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            '$minutes:${seconds.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Accuracy Stat
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: buttonCorrect, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: buttonCorrect,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).aniqlik,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.track_changes, color: buttonCorrect, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.accuracy.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 18,
                              color: buttonCorrect,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const SizedBox(height: 40),

            // Action Button: either go home or continue to Streak page
            AnimatedButton(
              height: 50,
              width: 220,
              color: primaryColor,
              onPressed: () async {
                if (alreadyClaimed) {
                  setState(() {
                    if (GameState.currentXP > GameState.maxXP) {
                      GameState.currentXP = GameState.maxXP;
                    }
                  });

                  final user = FirebaseAuth.instance.currentUser;
                  final userId = user?.uid;

                  if (userId != null) {
                    await GameState.saveState(userId);
                  } else {
                    print("User is not logged in!");
                  }

                  Navigator.pop(context, 'xpGained');
                } else {
                  // Go to Streak page to claim lightning
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Streak()),
                  ).then((resultFromStreak) async {
                    if (resultFromStreak == 'xpGained') {
                      // Update game state
                      setState(() {
                        if (GameState.currentXP > GameState.maxXP) {
                          GameState.currentXP = GameState.maxXP;
                        }
                        GameState.lightnings += 1;
                        GameState.lastLightningDate = today;
                      });

                      final user = FirebaseAuth.instance.currentUser;
                      final userId = user?.uid;
                      if (userId != null) {
                        await GameState.saveState(userId);
                      }

                      // ✅ Now pop SuccessPage itself with xpGained
                      Navigator.pop(context, 'xpGained');
                    }
                  });
                }
              },
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}