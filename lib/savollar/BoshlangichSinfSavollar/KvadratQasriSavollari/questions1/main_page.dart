// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question10.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question9.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/result_pages/LoserPage.dart';
import 'package:alochi_math_app/result_pages/SuccessPage.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question1.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Question2.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class MainPage1 extends StatefulWidget {
  const MainPage1({super.key});

  @override
  State<MainPage1> createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
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

      if (result == 'lostHeart') {
        Navigator.pop(context, 'lostHeart');
      } else {
        setState(() {});
      }
    } else {
      setState(() {});
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

  void finishQuiz() {
    Duration totalDuration = DateTime.now().difference(startTime);
    int totalQuestions = 10;
    int correctAnswers = totalQuestions - incorrectQuestions.length;
    double accuracy = (correctAnswers / totalQuestions) * 100;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SuccessPage(duration: totalDuration, accuracy: accuracy),
      ),
    ).then((result) {
      if (result == 'xpGained') {
        Navigator.pop(context, 'xpGained');
      } else {
        setState(() {});
      }
    });
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

    await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animations/MrSquareCrying.json',
                      height: 180,
                      width: 170,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      S.of(context).darstTugashiga,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedButton(
                      height: 45,
                      width: 270,
                      color: primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                        shouldExit = false;
                      },
                      child: Text(
                        S.of(context).darsDavomEtish,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedButton(
                    height: 45,
                    width: 270,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context); 
                      Navigator.pop(context, 'quit');
                      shouldExit = true;
                    },
                    child: Text(
                      S.of(context).chiqish,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
            ],
          ),
        );
      },
    );

    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: showAppBar()
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60), // height of your custom AppBar
                child: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _onWillPop(),
                        child: Image.asset('assets/icons/Exit.png', width: 30, height: 30),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              children: [
                                // main blue bar
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: currentXP / maxXP),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) => LinearProgressIndicator(
                                    value: value,
                                    borderRadius: BorderRadius.circular(30),
                                    minHeight: 17,
                                    backgroundColor: greyColor,
                                    color: primaryColor,
                                  ),
                                ),

                                // highlight line
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: currentXP / maxXP),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) {
                                    final fillWidth = constraints.maxWidth * value;
                                    // shrink factor
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
                      Image.asset('assets/icons/Heart.png', width: 30, height: 30),
                      const SizedBox(width: 5),
                      Text(
                        '$hp',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontFamily: primaryFont,
                          color: red,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: getCurrentQuestion(),
      ),
    );
  }
}
