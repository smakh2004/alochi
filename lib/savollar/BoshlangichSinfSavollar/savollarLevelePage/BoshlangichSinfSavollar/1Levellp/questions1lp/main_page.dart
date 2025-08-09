// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question10.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question9.dart';
import 'package:alochi_math_app/result_pages/LoserPage.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question1.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Question2.dart';

class MainPage1LevelPage extends StatefulWidget {
  const MainPage1LevelPage({super.key});

  @override
  State<MainPage1LevelPage> createState() => _MainPage1LevelPageState();
}

class _MainPage1LevelPageState extends State<MainPage1LevelPage> {
  int hp = 3;
  List<int> incorrectQuestions = [];
  double currentXP = 0;
  double maxXP = 100;
  bool showingIncorrectQuestions = false;
  int currentQuestionIndex = 0;
  int incorrectQuestionPointer = 0;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  void updateXP(double xpGained) {
    setState(() {
      currentXP += xpGained;
      if (currentXP > maxXP) currentXP = maxXP;
    });
  }

  void handleIncorrectAnswer(int questionIndex) async {
    if (!incorrectQuestions.contains(questionIndex)) {
      incorrectQuestions.add(questionIndex);
    }

    hp--;

    if (hp <= 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoserPage()),
      );

      if (!mounted) return;

      if (result == 'lostHeart') {
        Navigator.pop(context, 'lostHeart');
      } else {
        setState(() {});
      }
    } else {
      if (mounted) setState(() {});
    }
  }

  void goToNextQuestion() {
    if (!showingIncorrectQuestions) {
      currentQuestionIndex++;

      if (currentQuestionIndex >= 10) {
        if (incorrectQuestions.isNotEmpty) {
          setState(() {
            showingIncorrectQuestions = true;
            incorrectQuestionPointer = 0;
          });
        } else {
          finishQuiz();
        }
      } else {
        setState(() {});
      }
    } else {
      incorrectQuestionPointer++;

      if (incorrectQuestionPointer >= incorrectQuestions.length) {
        finishQuiz();
      } else {
        setState(() {});
      }
    }
  }

  // In MainPage.dart
  void finishQuiz() {

    // Replace push with pushReplacement
    Navigator.pop(context);
  }

  Widget getCurrentQuestion() {
    if (!showingIncorrectQuestions) {
      switch (currentQuestionIndex) {
        case 0:
          return Question1(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(0));
        case 1:
          return Question2(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(1));
        case 2:
          return Question3(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(2));
        case 3:
          return Question4(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(3));
        case 4:
          return Question5(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(4));
        case 5:
          return Question6(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(5));
        case 6:
          return Question7(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(6));
        case 7:
          return Question8(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(7));
        case 8:
          return Question9(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(8));
        case 9:
          return Question10(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () => handleIncorrectAnswer(9));
        default:
          return const BoshlangichSinf();
      }
    } else {
      int qIndex = incorrectQuestions[incorrectQuestionPointer];
      switch (qIndex) {
        case 0:
          return Question1(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 1:
          return Question2(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 2:
          return Question3(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 3:
          return Question4(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 4:
          return Question5(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 5:
          return Question6(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 6:
          return Question7(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 7:
          return Question8(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 8:
          return Question9(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 9:
          return Question10(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        default:
          return const BoshlangichSinf();
      }
    }
  }

  bool showAppBar() =>
      (!showingIncorrectQuestions && currentQuestionIndex < 10) ||
      (showingIncorrectQuestions && incorrectQuestionPointer < incorrectQuestions.length);

  Future<bool> _onWillPop() async {
    bool shouldExit = false;
    Navigator.pop(context);
    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showAppBar()
          ? PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0, // remove shadow
                title: Row(
                  children: [
                    // Exit button triggers confirmation dialog
                    GestureDetector(
                      onTap: () => _onWillPop(),
                      child: Image.asset(
                        'assets/icons/Exit.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // XP progress bar with animated tween
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              // main blue bar
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: currentXP / maxXP,
                                ),
                                duration: const Duration(milliseconds: 500),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    borderRadius: BorderRadius.circular(30),
                                    minHeight: 17,
                                    backgroundColor: greyColor,
                                    color: primaryColor,
                                  );
                                },
                              ),

                              // highlight line
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: currentXP / maxXP,
                                ),
                                duration: const Duration(milliseconds: 500),
                                builder: (context, value, child) {
                                  final fillWidth = constraints.maxWidth * value;

                                  // shrink factor: start at 0.5 when value=0, go to 0.9 when value=1
                                  final shrinkFactor = 0.5 + (0.9 - 0.5) * value;
                                  final highlightWidth = fillWidth * shrinkFactor;

                                  return Positioned(
                                    left: (fillWidth - highlightWidth) / 2,
                                    top: 3.5,
                                    child: Container(
                                      width: highlightWidth,
                                      height: 4.5,
                                      decoration: BoxDecoration(
                                        color: lighterBlue,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),

                    // HP icon and count display
                    Image.asset(
                      'assets/icons/Heart.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$hp',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontFamily: BoldFont,
                        color: red,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: getCurrentQuestion(),
    );
  }
}
