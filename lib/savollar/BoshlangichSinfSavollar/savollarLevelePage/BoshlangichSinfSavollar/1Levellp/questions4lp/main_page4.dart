// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:alochi_math_app/result_pages/LoserPage.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question31(clock).dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question32.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question33.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question34.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question35.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question36.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question37.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question38.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question39.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/Question40.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';

class MainPage4LevelPage extends StatefulWidget {
  const MainPage4LevelPage({super.key});

  @override
  State<MainPage4LevelPage> createState() => _MainPage4LevelPageState();
}

class _MainPage4LevelPageState extends State<MainPage4LevelPage> {
  // Health points (number of lives)
  int hp = 3;

  // List to store indexes of questions answered incorrectly
  List<int> incorrectQuestions = [];

  // Current XP and max XP for progress tracking
  double currentXP = 0;
  double maxXP = 100;

  // Whether currently reviewing incorrect questions
  bool showingIncorrectQuestions = false;

  // Index for current question in normal mode
  int currentQuestionIndex = 0;

  // Index pointer for the incorrect questions review mode
  int incorrectQuestionPointer = 0;

  // Start time for timing the quiz session
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    // Record quiz start time
    startTime = DateTime.now();
  }

  // Update XP and limit to maxXP
  void updateXP(double xpGained) {
    setState(() {
      currentXP += xpGained;
      if (currentXP > maxXP) currentXP = maxXP;
    });
  }

  // Handle an incorrect answer
  void handleIncorrectAnswer(int questionIndex) async {
    // Add to incorrect questions if not already present
    if (!incorrectQuestions.contains(questionIndex)) {
      incorrectQuestions.add(questionIndex);
    }

    // Reduce health points by 1
    hp--;

    // If no HP left, navigate to LoserPage
    if (hp <= 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoserPage()),
      );

      // If user lost heart on LoserPage, pop and pass that result back
      if (result == 'lostHeart') {
        Navigator.pop(context, 'lostHeart');
      } else {
        // Otherwise, just refresh state
        setState(() {});
      }
    } else {
      // If still have HP, just refresh UI
      setState(() {});
    }
  }

  // Navigate to the next question in sequence or handle completion
  void goToNextQuestion() {
    if (!showingIncorrectQuestions) {
      // Move to next question index
      currentQuestionIndex++;

      // Check if all questions done
      if (currentQuestionIndex >= 10) {
        if (incorrectQuestions.isNotEmpty) {
          // If have incorrect questions, switch to review mode
          setState(() {
            showingIncorrectQuestions = true;
            incorrectQuestionPointer = 0;
          });
        } else {
          // Navigate to SuccessPage with duration and accuracy info
          Navigator.pop(context);
        }
      } else {
        // Still more questions to go, just refresh UI
        setState(() {});
      }
    } else {
      // In review mode for incorrect questions, move pointer forward
      incorrectQuestionPointer++;

      // If finished reviewing incorrect questions
      if (incorrectQuestionPointer >= incorrectQuestions.length) {
        // Show SuccessPage after reviewing all incorrect questions
        Navigator.pop(context);
      } else {
        // More incorrect questions to review, refresh UI
        setState(() {});
      }
    }
  }

  // Returns the current question widget based on current index
  Widget getCurrentQuestion() {
    if (!showingIncorrectQuestions) {
      // Normal quiz mode
      if (currentQuestionIndex < 0 || currentQuestionIndex >= 10) {
        return const BoshlangichSinf();
      }
      switch (currentQuestionIndex) {
        case 0:
          return Question31(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(0),
          );
        case 1:
          return Question32(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(1),
          );
        case 2:
          return Question33(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(2),
          );
        case 3:
          return Question34(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(3),
          );
        case 4:
          return Question35(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(4),
          );
        case 5:
          return Question36(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(5),
          );
        case 6:
          return Question37(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(6),
          );
        case 7:
          return Question38(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(7),
          );
        case 8:
          return Question39(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(8),
          );
        case 9:
          return Question40(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(9),
          );
        default:
          return const BoshlangichSinf();
      }
    } else {
      // Review mode for incorrect questions
      if (incorrectQuestionPointer < 0 || incorrectQuestionPointer >= incorrectQuestions.length) {
        return const BoshlangichSinf();
      }
      int qIndex = incorrectQuestions[incorrectQuestionPointer];
      // For review questions, onIncorrect is empty because user already marked wrong
      switch (qIndex) {
        case 0:
          return Question31(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 1:
           return Question32(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 2:
          return Question33(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 3:
          return Question34(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 4:
          return Question35(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 5:
          return Question36(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 6:
          return Question37(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 7:
          return Question38(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 8:
          return Question39(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        case 9:
          return Question40(onXPUpdate: updateXP, onNext: goToNextQuestion, onIncorrect: () {});
        default:
          return const BoshlangichSinf();
      }
    }
  }

  // Determine whether to show the top app bar (progress and HP)
  bool showAppBar() =>
      (!showingIncorrectQuestions && currentQuestionIndex < 10) ||
      (showingIncorrectQuestions && incorrectQuestionPointer < incorrectQuestions.length);

  // Show confirmation dialog when user tries to exit quiz early
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
