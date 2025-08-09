import 'dart:async';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions1lp/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions2lp/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions3lp/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions4lp/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions5lp/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions6lp/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions7lp/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions8lp/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions9lp/main_page9.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savollarLevelePage/BoshlangichSinfSavollar/1Levellp/questions10lp/main_page10.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions10/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions2/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions3/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions5/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions6/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions7/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions8/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions9/main_page9.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
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
    required Widget Function() inProgressPageBuilder,
    required Widget Function() levelPageBuilder,
  }) {
    final requiredXp = levelXpRequirements[level] ?? 0;
    final isUnlocked = GameState.currentXP >= requiredXp;

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
                final bool isInProgress = GameState.currentXP == (level - 1) * 10;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        isInProgress ? inProgressPageBuilder() : levelPageBuilder(),
                  ),
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
          S.of(context).KvadratQasri,
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
                  title: 'Sonlar va sanash',
                  inProgressPageBuilder: () => MainPage1(),
                  levelPageBuilder: () => MainPage1LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 2,
                  title: 'Raqamlar xonasining qiymati',
                  inProgressPageBuilder: () => MainPage2(),
                  levelPageBuilder: () => MainPage2LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 3,
                  title: 'Qo‘shish va ayirish',
                  inProgressPageBuilder: () => MainPage3(),
                  levelPageBuilder: () => MainPage3LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 4,
                  title: 'Sodda amaliy masalalar',
                  inProgressPageBuilder: () => MainPage4(),
                  levelPageBuilder: () => MainPage4LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 5,
                  title: 'Sonlarni taqqoslash',
                  inProgressPageBuilder: () => MainPage5(),
                  levelPageBuilder: () => MainPage5LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 6,
                  title: 'Sanab o‘tish',
                  inProgressPageBuilder: () => MainPage6(),
                  levelPageBuilder: () => MainPage6LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 7,
                  title: 'O‘lchov birliklari bilan tanishish',
                  inProgressPageBuilder: () => MainPage7(),
                  levelPageBuilder: () => MainPage7LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 8,
                  title: 'Soatni o‘rganish',
                  inProgressPageBuilder: () => MainPage8(),
                  levelPageBuilder: () => MainPage8LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 9,
                  title: 'Geometrik shakllar',
                  inProgressPageBuilder: () => MainPage9(),
                  levelPageBuilder: () => MainPage9LevelPage(),
                ),
                levelButton(
                  context: context,
                  level: 10,
                  title: 'Sodda diagrammalar',
                  inProgressPageBuilder: () => MainPage10(),
                  levelPageBuilder: () => MainPage10levelPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
