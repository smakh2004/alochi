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
  final Duration duration; 
  final int xp;            
  final double accuracy; 

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
  late int localScoreDop;
  late int localGems = 20;

  @override
  void initState() {
    super.initState();

    // ✅ Always increase XP and stats when SuccessPage is reached
    GameState.currentXP += widget.xp;
    if (GameState.currentXP > GameState.maxXP) {
      GameState.currentXP = GameState.maxXP;
    }

    GameState.kopaytirish += GameState.kopaytirishDop;
    GameState.kopaytirishDop = 0;

    GameState.arifmetika += GameState.arifmetikaDop;
    GameState.arifmetikaDop = 0;

    GameState.logika += GameState.logikaDop;
    GameState.logikaDop = 0;

    localScoreDop = GameState.scoreDop;
    GameState.score += GameState.scoreDop;
    GameState.scoreDop = 0;

    GameState.gems += 20;

    // ✅ Save immediately
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    if (userId != null) {
      GameState.saveState(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final minutes = widget.duration.inMinutes;
    final seconds = widget.duration.inSeconds % 60;

    // Check if lightning reward has already been claimed today
    final today = DateTime.now();
    final alreadyClaimed = GameState.lastLightningDate != null &&
        GameState.lastLightningDate!.day == today.day &&
        GameState.lastLightningDate!.month == today.month &&
        GameState.lastLightningDate!.year == today.year;

    // Button label
    final buttonLabel =
        alreadyClaimed ? S.of(context).uygaQaytish : S.of(context).davomEtish;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      // Animation
                      Lottie.asset(
                        'assets/animations/MrSquareCorrect.json',
                        height: 250,
                        width: 240,
                      ),
                      const SizedBox(height: 10),

                      // Title
                      Text(
                        S.of(context).ajoyibDars,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: BoldFont,
                          color: yellow,
                        ),
                      ),
                      Text(
                        S.of(context).beast,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font,
                          fontSize: 18,
                          color: grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Stat blocks
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Score
                          _statBlock(
                            color: yellow,
                            title: S.of(context).ochko,
                            value: '$localScoreDop',
                            icon: Image.asset('assets/icons/Points.png', width: 24, height: 24),
                          ),
                          const SizedBox(width: 15),

                          // Time
                          _statBlock(
                            color: primaryColor,
                            title: S.of(context).vaqt,
                            value: '$minutes:${seconds.toString().padLeft(2, '0')}',
                            icon: Image.asset('assets/icons/Time.png', width: 24, height: 24),
                          ),
                          const SizedBox(width: 15),

                          // Accuracy
                          _statBlock(
                            color: greenNew,
                            title: S.of(context).aniqlik,
                            value: '${widget.accuracy.toStringAsFixed(0)}%',
                            icon: const Icon(Icons.track_changes, size: 24, color: greenNew),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 50),
                      // Gems
                      Column(
                        children: [
                          Lottie.asset(
                            'assets/animations/Gems.json',
                            height: 80,
                            width: 280,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: green,
                                  fontFamily: Font,
                                ),
                              ),
                              Text(
                                '$localGems',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: green,
                                  fontFamily: Font,
                                ),
                              ),
                              Image.asset('assets/icons/Diamond.png', width: 28, height: 28),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Button
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedButton(
                  height: 50,
                  width: 310,
                  color: primaryColor,
                  onPressed: () async {
                    final today = DateTime.now();
                    final last = GameState.lastLightningDate;
                    final isSameDay = last != null &&
                        last.year == today.year &&
                        last.month == today.month &&
                        last.day == today.day;

                    final user = FirebaseAuth.instance.currentUser;
                    final userId = user?.uid;
                    if (userId != null) {
                      await GameState.saveState(userId); // Save updated XP and stats
                    }

                    if (!isSameDay) {
                      // Navigate to Streak (lightning will be handled there)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Streak()),
                      );
                    } else {
                      // Already claimed today → back to home
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: Font,
                      color: Colors.white,
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

  Widget _statBlock({
    required Color color,
    required String title,
    required String value,
    required Widget icon,
  }) {
    return Container(
      width: 90,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: Font,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontFamily: Font,
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
