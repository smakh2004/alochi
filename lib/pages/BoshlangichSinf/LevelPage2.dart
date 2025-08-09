import 'dart:async';

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions1lp/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions10lp/main_page10.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions2lp/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions3lp/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions4lp/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions5lp/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions6lp/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions7lp/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions8lp/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions9lp/main_page9.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class LevelPage2 extends StatefulWidget {
  const LevelPage2({super.key});

  @override
  State<LevelPage2> createState() => _LevelPage2State();
}

class _LevelPage2State extends State<LevelPage2> {
  final Map<int, int> levelXpRequirements = const {
    1: 0,
    2: 10,
    3: 20,
    4: 30,
    5: 40,
    6: 50,
    7: 60,
    8: 70,
    9: 80,
    10: 90,
  };

  late int hearts;

  bool get isLevelPage2Unlocked => GameState.currentXP >= GameState.maxXP;

  @override
  void initState() {
    super.initState();
    hearts = GameState.hearts;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (hearts != GameState.hearts) {
          setState(() {
            hearts = GameState.hearts;
          });
        }
      });
    });
  }

  Widget levelButton({
    required BuildContext context,
    required int level,
    required String title,
    required Widget Function() pageBuilder,
  }) {
    final requiredXp = levelXpRequirements[level] ?? 0;
    final isUnlocked = isLevelPage2Unlocked && GameState.currentXP2 >= requiredXp;

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          AnimatedButton(
            width: 60,
            height: 60,
            borderRadius: 60,
            onPressed: () {
              if (isUnlocked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageBuilder()),
                );
              }
            },
            color: isUnlocked ? primaryColor : Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: isUnlocked ? borderBlue : greyColor, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text(
                '$level',
                style: TextStyle(
                  fontFamily: BoldFont,
                  fontSize: 35,
                  color: isUnlocked ? Colors.white : grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: Font,
                  color: questionColor.withOpacity(isUnlocked ? 1 : 0.5),
                  fontSize: 20,
                  height: 1
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.keyboard_arrow_down, color: darkGrey),
          ),
        ),
        title: Text(
          S.of(context).uchburchakQasri,
          style: TextStyle(
            color: darkGrey,
            fontFamily: BoldFont,
          ),
        ),
        actions: [
          Row(
            children: [
              Image.asset('assets/icons/Heart.png', width: 28, height: 28),
              const SizedBox(width: 4),
              Text(
                hearts.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: BoldFont,
                  color: red,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/Gates.png',
                    height: 100,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),
                levelButton(
                  context: context,
                  level: 1,
                  title: '1000 gacha sonlar va xonalar qiymati',
                  pageBuilder: () => MainPage1LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 2,
                  title: 'Qo‘shish va ayirish',
                  pageBuilder: () => MainPage2LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 3,
                  title: 'Toq va juft sonlar',
                  pageBuilder: () => MainPage3LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 4,
                  title: 'Ko‘paytirish va bo‘lishga kirish',
                  pageBuilder: () => MainPage4LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 5,
                  title: 'Soatni o‘rganish',
                  pageBuilder: () => MainPage5LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 6,
                  title: 'Pul birliklari ',
                  pageBuilder: () => MainPage6LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 7,
                  title: 'O‘lchovlar (santimetr, metr, gramm, litr)',
                  pageBuilder: () => MainPage7LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 8,
                  title: 'Ma’lumotlarni o‘qish',
                  pageBuilder: () => MainPage8LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 9,
                  title: 'Geometrik shakllar',
                  pageBuilder: () => MainPage9LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 10,
                  title: 'Geometrik shakllar va oddiy ulushlar',
                  pageBuilder: () => MainPage10levelPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
