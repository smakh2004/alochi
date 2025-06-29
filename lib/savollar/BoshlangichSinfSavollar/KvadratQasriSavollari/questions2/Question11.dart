// ignore_for_file: deprecated_member_use, sort_child_properties_last, unused_local_variable

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class Question11 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question11({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question11> createState() => _Question11State();
}

class _Question11State extends State<Question11> {
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  Set<String> selectedLabels = {};
  final Set<String> correctAnswers = {'1', '3'};

  final List<Map<String, String>> answerOptions = [
    {
      'label': '1',
      'image': 'assets/question2_images/1figure.png',
      'correct': 'assets/question2_images/1figure(correct).png',
      'selected': 'assets/question2_images/1figure(selected).png'
    },
    {
      'label': '2',
      'image': 'assets/question2_images/2figure.png',
      'wrong': 'assets/question2_images/2figure(wrong).png',
      'selected': 'assets/question2_images/2figure(selected).png'
    },
    {
      'label': '3',
      'image': 'assets/question2_images/3figure.png',
      'correct': 'assets/question2_images/3figure(correct).png',
      'selected': 'assets/question2_images/3figure(selected).png'
    },
    {
      'label': '4',
      'image': 'assets/question2_images/4figure.png',
      'wrong': 'assets/question2_images/4figure(wrong).png',
      'selected': 'assets/question2_images/4figure(selected).png'
    },
  ];

  bool get isAnswerSelected => selectedLabels.length == 2;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget buildAnswerButton(Map<String, String> item) {
      final label = item['label']!;
      final bool isSelected = selectedLabels.contains(label);

      Color buttonColor = Colors.white;
      Color borderColor = greyColor;
      String imagePath = item['image']!;

      if (isChecked) {
        if (isSelected && correctAnswers.contains(label)) {
          // Show correct only if the user selected the correct answer
          buttonColor = lightGreen;
          borderColor = buttonGreen;
          imagePath = item['correct'] ?? imagePath;
        } else if (isSelected && !correctAnswers.contains(label)) {
          // Show incorrect only for selected wrong answers
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
        width: 120,
        height: 120,
        color: buttonColor,
        onPressed: () {
          if (isChecked) return;
          setState(() {
            if (isSelected) {
              selectedLabels.remove(label);
            } else {
              if (selectedLabels.length < 2) {
                selectedLabels.add(label);
              }
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
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
                            S.of(context).qaysiShakillar,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: lightBlue,
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
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
                            if (selectedLabels.length == 2 && selectedLabels.containsAll(correctAnswers)) {
                              submitButtonColor = primaryCorrect;
                              isCorrect = true;
                              widget.onXPUpdate(10);
                              setState(() {
                                GameState.arifmetikaDop = 0;
                                GameState.logikaDop = 0;
                                GameState.scoreDop = 0;
                                GameState.logikaDop += 0.5;
                                GameState.scoreDop += 1;
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
