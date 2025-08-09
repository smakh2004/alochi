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
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class MainPage10levelPage extends StatefulWidget {
  const MainPage10levelPage({super.key});

  @override
  State<MainPage10levelPage> createState() => _MainPage10levelPageState();
}

class _MainPage10levelPageState extends State<MainPage10levelPage> {
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
          return Question1(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(0),
          );
        case 1:
          return Question2(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(1),
          );
        case 2:
          return Question3(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(2),
          );
        case 3:
          return Question4(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(3),
          );
        case 4:
          return Question5(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(4),
          );
        case 5:
          return Question6(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(5),
          );
        case 6:
          return Question7(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(6),
          );
        case 7:
          return Question8(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(7),
          );
        case 8:
          return Question9(
            onXPUpdate: updateXP,
            onNext: goToNextQuestion,
            onIncorrect: () => handleIncorrectAnswer(8),
          );
        case 9:
          return Question10(
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

  // Determine whether to show the top app bar (progress and HP)
  bool showAppBar() =>
      (!showingIncorrectQuestions && currentQuestionIndex < 10) ||
      (showingIncorrectQuestions && incorrectQuestionPointer < incorrectQuestions.length);

  // Show confirmation dialog when user tries to exit quiz early
  void showExitConfirmation() {
    showModalBottomSheet(
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
                  const Center(
                    child: Text(
                      'Iltimos kuting, dars tugashiga \n'
                      '1 daqiqa qoldi!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                        // Close the modal and continue quiz
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'DARSNI DAVOM ETIRISH',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedButton(
                    height: 45,
                    width: 270,
                    color: Colors.red,
                    onPressed: () {
                      // Close modal and then exit quiz, sending 'quit' result
                      Navigator.pop(context);
                      Navigator.pop(context, 'quit');
                    },
                    child: const Text(
                      'CHIQISH',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Space at top for status bar
          const SizedBox(height: 55),

          // Show app bar with XP progress and HP if applicable
          if (showAppBar())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              color: Colors.white,
              child: Row(
                children: [
                  // Exit button triggers confirmation dialog
                  GestureDetector(
                    onTap: showExitConfirmation,
                    child: Image.asset('assets/icons/Exit.png', width: 30, height: 30),
                  ),
                  const SizedBox(width: 10),

                  // XP progress bar with animated tween
                  Expanded(
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: currentXP / maxXP),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) => LinearProgressIndicator(
                        value: value,
                        borderRadius: BorderRadius.circular(20),
                        minHeight: 20,
                        backgroundColor: Colors.grey[300],
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // HP icon and count display
                  Image.asset('assets/icons/Heart.png', width: 30, height: 30),
                  const SizedBox(width: 5),
                  Text(
                    '$hp',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      fontFamily: BoldFont,
                      color: red,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),

          // Main question area fills remaining space
          Expanded(child: getCurrentQuestion()),
        ],
      ),
    );
  }
}
