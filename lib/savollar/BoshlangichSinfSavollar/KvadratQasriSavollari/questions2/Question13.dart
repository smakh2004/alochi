// ignore_for_file: deprecated_member_use, sort_child_properties_last, unused_local_variable

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class Question13 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question13({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question13> createState() => _Question13State();
}

class _Question13State extends State<Question13> {
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  String? selectedLabel;

  final String correctAnswer = '4';

  final List<Map<String, String>> answerOptions = [
    {
      'label': '1', // five
      'image': 'assets/question2_images/Q13_1.png',
      'wrong': 'assets/question2_images/Q13_1(wrong).png',
      'selected': 'assets/question2_images/Q13_1(selected).png'
    },
    {
      'label': '2', // circle
      'image': 'assets/question2_images/Q13_2.png',
      'wrong': 'assets/question2_images/Q13_2(wrong).png',
      'selected': 'assets/question2_images/Q13_2(selected).png',
    },
    {
      'label': '3', // square
      'image': 'assets/question2_images/Q13_3.png',
      'wrong': 'assets/question2_images/Q13_3(wrong).png',
      'selected': 'assets/question2_images/Q13_3(selected).png'
    },
    {
      'label': '4', // triangle
      'image': 'assets/question2_images/Q13_4.png',
      'correct': 'assets/question2_images/Q13_4(correct).png',
      'selected': 'assets/question2_images/Q13_4(selected).png'
    },
  ];

  bool get isAnswerSelected => selectedLabel != null;
  bool isCorrect = false;

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
        if (isSelected) {
          if (label == correctAnswer) {
            // User selected correct answer
            buttonColor = lightGreen;
            borderColor = buttonGreen;
            imagePath = item['correct'] ?? imagePath;
          } else {
            // User selected wrong answer
            buttonColor = lightRed;
            borderColor = buttonRed;
            imagePath = item['wrong'] ?? imagePath;
          }
        }
      } else if (isSelected) {
        buttonColor = lightBlue;
        borderColor = buttonBlue;
        imagePath = item['selected'] ?? imagePath;
      }

      return AnimatedButton(
        width: 150,
        height: 90,
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).azizChizilgan,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20),
                            Image.asset(
                              'assets/question2_images/Q13.png',
                              width: size.width * 0.5,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: answerOptions.map(buildAnswerButton).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isChecked
              ? Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? buttonCorrect : red,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isCorrect ? S.of(context).togriJavob : S.of(context).notogriJavob,
                          style: TextStyle(
                            color: isCorrect ? buttonCorrect : red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: AnimatedButton(
                          onPressed: widget.onNext,
                          color: isCorrect ? buttonCorrect : red,
                          height: 50,
                          width: 310,
                          child: Text(
                            S.of(context).davomEtish,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : AbsorbPointer(
                absorbing: !isAnswerSelected,
                child: Opacity(
                  opacity: !isAnswerSelected ? 0.5 : 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Center(
                      child: AnimatedButton(
                        color: submitButtonColor,
                        height: 50,
                        width: 310,
                        onPressed: () {
                          if (!isChecked) {
                            if (selectedLabel == correctAnswer) {
                              submitButtonColor = primaryCorrect;
                              isCorrect = true;
                              widget.onXPUpdate(10);
                              setState(() {
                                GameState.logikaDop += 0.5;
                                GameState.scoreDop += 5;
                              });
                            } else {
                              submitButtonColor = primaryIncorrect;
                              isCorrect = false;
                              widget.onXPUpdate(5);
                              widget.onIncorrect();
                            }
                            setState(() {
                              isChecked = true;
                            });
                          }
                        },
                        child: Text(
                          S.of(context).tekshirish,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
}