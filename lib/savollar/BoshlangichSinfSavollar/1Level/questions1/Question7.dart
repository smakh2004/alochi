// ignore_for_file: deprecated_member_use, sort_child_properties_last, unused_local_variable

import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/1Level/questions1/Hint7.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class Question7 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question7({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question7> createState() => _Question7State();
}

class _Question7State extends State<Question7> {
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  String? selectedLabel;

  final String correctAnswer = '4';

  final List<Map<String, String>> answerOptions = [
    {
      'label': '1', // five
      'image': 'assets/question_images/Q7(fiveDefault).png',
      'wrong': 'assets/question_images/Q7(fiveIncorrect).png',
      'selected': 'assets/question_images/Q7(fiveSelected).png'
    },
    {
      'label': '2', // circle
      'image': 'assets/question_images/Q7(circleDefault).png',
      'wrong': 'assets/question_images/Q7(circleIncorrect).png',
      'selected': 'assets/question_images/Q7(circleSelected).png',
    },
    {
      'label': '3', // square
      'image': 'assets/question_images/Q7(squareDefault).png',
      'wrong': 'assets/question_images/Q7(squareIncorrect).png',
      'selected': 'assets/question_images/Q7(squareSelected).png'
    },
    {
      'label': '4', // triangle
      'image': 'assets/question_images/Q7(triangleDefault).png',
      'correct': 'assets/question_images/Q7(triangleCorrect).png',
      'selected': 'assets/question_images/Q7(triangleSelected).png'
    },
  ];

  bool get isAnswerSelected => selectedLabel != null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget buildAnswerButton(Map<String, String> item) {
      final label = item['label']!;
      final bool isSelected = selectedLabel == label;

      Color buttonColor = Colors.white;
      Color borderColor = greyColor;
      String imagePath = item['image']!;

      if (isChecked) {
        if (isSelected && label == correctAnswer) {
          buttonColor = lightGreen;
          borderColor = buttonGreen;
          imagePath = item['correct'] ?? imagePath;
        } else if (isSelected && label != correctAnswer) {
          buttonColor = lightRed;
          borderColor = buttonRed;
          imagePath = item['wrong'] ?? imagePath;
        }
      } else {
        if (isSelected) {
          buttonColor = lightBlue;
          borderColor = buttonBlue;
          imagePath = item['selected'] ?? imagePath;
        }
      }

      return AnimatedButton(
        width: 150,
        height: 170,
        color: buttonColor,
        onPressed: () {
          if (isChecked) return;
          setState(() {
            selectedLabel = label;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).qaysiBirShakl,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor,
                      height: 1.2
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                Spacer(),
                                Center(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    alignment: WrapAlignment.center,
                                    children: answerOptions.map(buildAnswerButton).toList(),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
              isChecked
                ? Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: selectedLabel == correctAnswer ? lightGreen : const Color(0xFFFFE4E1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top row with icon and "Correct/Incorrect"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selectedLabel == correctAnswer ? Icons.check_circle : Icons.cancel,
                            color: selectedLabel == correctAnswer ? buttonCorrect : red,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedLabel == correctAnswer ? S.of(context).togriJavob : S.of(context).notogriJavob,
                            style: TextStyle(
                              color: selectedLabel == correctAnswer ? buttonCorrect : red,
                              fontSize: 22,
                              fontFamily: Font,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (selectedLabel == correctAnswer)
                        // Only Davom Etish button with full width
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: AnimatedButton(
                              onPressed: widget.onNext,
                              color: buttonCorrect,
                              height: 50,
                              width: 310,
                              borderRadius: 12,
                              child: Text(
                                S.of(context).davomEtish,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: Font,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        // Incorrect answer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(milliseconds: 600),
                                    pageBuilder: (_, __, ___) => const Hint7(),
                                    transitionsBuilder: (_, animation, __, child) => SlideTransition(
                                      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                                          .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                              height: 50,
                              width: 120, 
                              color: orange,
                              borderRadius: 12,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.lightbulb, size: 30, color: Colors.white),
                                  Text(
                                    S.of(context).hint,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: Font,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16), 
                            AnimatedButton(
                              onPressed: widget.onNext,
                              color: red,
                              height: 50,
                              width: 160, 
                              borderRadius: 12,
                              child: Text(
                                S.of(context).davomEtish,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: Font,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
                : AbsorbPointer(
                    absorbing: !isAnswerSelected,
                    child: Opacity(
                      opacity: !isAnswerSelected ? 0.5 : 1,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 57),
                              AnimatedButton(
                                color: submitButtonColor,
                                height: 50,
                                width: 310,
                                onPressed: () {
                                  if (!isChecked) {
                                    final isCorrect = selectedLabel == correctAnswer;
                              
                                    submitButtonColor = isCorrect ? primaryCorrect : primaryIncorrect;
                                    widget.onXPUpdate(isCorrect ? 10 : 5);
                                    if (!isCorrect) widget.onIncorrect();
                              
                                    setState(() {
                                      isChecked = true;
                                      GameState.scoreDop += 1;
                                    });
                                  }
                                },
                                child: Text(
                                  S.of(context).tekshirish,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: Font,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
