// Importing necessary files and packages
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions2/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions3/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions4/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions5/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions6/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions7/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions8/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions9/main_page9.dart';
import 'package:alochi_math_app/UchburchakPiramidasiSavollari/questions1/main_page.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/GameState.dart';

// ListOfCastles is the main screen showing all castle cards (levels)
class ListOfCastles extends StatefulWidget {
  const ListOfCastles({super.key});

  @override
  State<ListOfCastles> createState() => _ListOfCastlesState();
}

class _ListOfCastlesState extends State<ListOfCastles> {
  // Determines which stage the user is currently in (1st, 2nd, or 3rd)
  int _getCurrentStage() {
    if (GameState.currentXP < GameState.maxXP) {
      return 1; // Still in the first stage
    } else if (GameState.TcurrentXP < GameState.TmaxXP) {
      return 2; // Moved to second stage
    } else {
      return 3; // Future third stage
    }
  }

  // Returns the appropriate main page (question set) based on current stage and XP
  Widget _getCurrentMainPage() {
    final int stage = _getCurrentStage();
    int level;

    if (stage == 1) {
      level = (GameState.currentXP / (GameState.maxXP / 10)).floor(); // levels 0–9
    } else if (stage == 2) {
      level = (GameState.TcurrentXP / (GameState.TmaxXP / 10)).floor() + 9; // levels 9–18
    } else {
      level = 0; // fallback default
    }

    // Map the level to the corresponding main page
    switch (level) {
      case 0: return MainPage1();
      case 1: return MainPage2();
      case 2: return MainPage3();
      case 3: return MainPage4();
      case 4: return MainPage5();
      case 5: return MainPage6();
      case 6: return MainPage7();
      case 7: return MainPage8();
      case 8: return MainPage9();
      case 9: return MainPage10();
      case 10: return MainPage2();
      // Future levels can be added here (case 9 to 18...)
      default: return MainPage10(); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title and back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(S.of(context).matematika, style: TextStyle(fontFamily: primaryFont, color: darkGrey)),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context, 'xpUpdated'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset('assets/icons/Exit.png', width: 30, height: 30),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // First castle: Kvadrat Qasri
            _buildCastleCardWithXPBar(
              imagePath: 'assets/images/KvadratQasri.png',
              title: "${S.of(context).kvadratQasriBirinchiBosqich}\n${S.of(context).kvadratQasriBirinchiBosqichDes}",
              subtitle: S.of(context).kvadratBirinchiBosqichDes,
              titleColor: primaryColor,
              subtitleColor: grey,
              currentXP: GameState.currentXP,
              maxXP: GameState.maxXP,
              xpBarColor: primaryColor,
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _getCurrentMainPage()),
                );
                setState(() {
                  if (result == 'xpGained') {
                    GameState.currentXP += GameState.maxXP / 10;
                    if (GameState.currentXP > GameState.maxXP) {
                      GameState.currentXP = GameState.maxXP;
                    }
                  } else if (result == 'lostHeart') {
                    GameState.hearts = (GameState.hearts > 0) ? GameState.hearts - 1 : 0;
                  }
                });
              },
            ),

            const SizedBox(height: 20),

            // Second castle: Uchburchak Piramidasi
            _buildCastleCardWithXPBar(
              imagePath: 'assets/images/UchburchakPiramidasi.png',
              title: '${S.of(context).uchburchakPiramidasiIkkinchiBosqich}\n${S.of(context).uchburchakPiramidasiIkkinchiBosqichDes}',
              subtitle: S.of(context).uchburchakIkkinchiBosqichDes,
              titleColor: red,
              subtitleColor: grey,
              currentXP: GameState.TcurrentXP,
              maxXP: GameState.TmaxXP,
              xpBarColor: red,
              onPressed: GameState.currentXP >= GameState.maxXP
                  ? () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _getCurrentMainPage()),
                      );
                      setState(() {
                        if (result == 'xpGained') {
                          GameState.TcurrentXP += GameState.TmaxXP / 10;
                          if (GameState.TcurrentXP > GameState.TmaxXP) {
                            GameState.TcurrentXP = GameState.TmaxXP;
                          }
                        } else if (result == 'lostHeart') {
                          GameState.hearts = (GameState.hearts > 0) ? GameState.hearts - 1 : 0;
                        }
                      });
                    }
                  : null,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper to build a castle card with XP progress bar
  Widget _buildCastleCardWithXPBar({
    required String imagePath,
    required String title,
    required String subtitle,
    required VoidCallback? onPressed,
    required Color titleColor,
    required Color subtitleColor,
    required double currentXP,
    required double maxXP,
    required Color xpBarColor,
  }) {
    final bool disabled = onPressed == null;
    return _buildCastleCardBase(
      imagePath: imagePath,
      title: title,
      subtitle: subtitle,
      titleColor: titleColor,
      subtitleColor: subtitleColor,
      onPressed: onPressed ?? () {},
      showXPBar: true,
      disabled: disabled,
      progress: currentXP / maxXP,
      xpBarColor: xpBarColor,
    );
  }

  // Generic card builder used for each castle block
  Widget _buildCastleCardBase({
    required String imagePath,
    required String title,
    required String subtitle,
    required Color titleColor,
    required Color subtitleColor,
    required VoidCallback onPressed,
    required bool showXPBar,
    required bool disabled,
    double progress = 0,
    Color xpBarColor = Colors.blue,
  }) {
    return Center(
      child: IgnorePointer(
        ignoring: disabled,
        child: Opacity(
          opacity: disabled ? 0.4 : 1.0,
          child: AnimatedButton(
            height: showXPBar ? 410 : 370,
            width: 310,
            color: Colors.white,
            onPressed: onPressed,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Castle image with greyscale if disabled
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ColorFiltered(
                        colorFilter: disabled
                            ? const ColorFilter.matrix(<double>[
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0.2126, 0.7152, 0.0722, 0, 0,
                                0, 0, 0, 1, 0,
                              ])
                            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and subtitle
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabled ? Colors.grey : titleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabled ? Colors.grey : subtitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // XP Progress Bar
                        if (showXPBar) ...[
                          const SizedBox(height: 30),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: progress),
                            duration: const Duration(milliseconds: 1000),
                            builder: (context, value, child) {
                              return LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(20),
                                value: value.clamp(0.0, 1.0),
                                backgroundColor: Colors.grey[300],
                                color: xpBarColor,
                                minHeight: 18,
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
