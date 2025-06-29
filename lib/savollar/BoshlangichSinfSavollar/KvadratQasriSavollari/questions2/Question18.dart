// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Question18 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question18({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question18> createState() => _Question18State();
}

class _Question18State extends State<Question18> {
  Color? droppedColor;
  String? droppedLabel;

  final List<Map<String, dynamic>> draggableButtons = [
    {'color': Colors.white, 'label': '1'},
    {'color': Colors.white, 'label': '2'}, // Correct
    {'color': Colors.white, 'label': '5'},
    {'color': Colors.white, 'label': '10'},
  ];

  final Map<String, String> symbolImages = {
    '1': 'assets/question2_images/coin1.png',
    '2': 'assets/question2_images/coin2.png',
    '5': 'assets/question2_images/coin5.png',
    '10': 'assets/question2_images/10coin.png',
  };

  Set<String> usedLabels = {};
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  bool get isAnswerSelected => droppedLabel != null;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        S.of(context).berilganMisolni,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/question2_images/20coin.png',
                            width: size.width * 0.14,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/question2_images/coin10.png',
                            width: size.width * 0.14,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/question2_images/coin10.png',
                            width: size.width * 0.14,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: lightBlue,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: primaryColor, 
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 55,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: lightBlue,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: primaryColor, 
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/question2_images/1coin.png',
                            width: size.width * 0.14,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '=51',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DragTarget<Map<String, dynamic>>(
                            onWillAccept: (data) => droppedLabel == null,
                            onAccept: (data) {
                              if (droppedLabel == null) {
                                setState(() {
                                  droppedColor = data['color'] as Color;
                                  droppedLabel = data['label'] as String;
                                  usedLabels.add(droppedLabel!);
                                });
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              return droppedColor == null
                                  ? DottedBorder(
                                      color: candidateData.isNotEmpty
                                          ? primaryColor
                                          : grey,
                                      strokeWidth: 2,
                                      dashPattern: [13, 3],
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(40),
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: lightGrey,
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),
                                    )
                                  : AnimatedButton(
                                      width: 60,
                                      height: 60,
                                      borderRadius: 40,
                                      color: isChecked
                                          ? (droppedLabel == '5' ? lightGreen : lightRed)
                                          : droppedColor!,
                                      onPressed: () {
                                        if (!isChecked) {
                                          setState(() {
                                            usedLabels.remove(droppedLabel);
                                            droppedColor = null;
                                            droppedLabel = null;
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: isChecked
                                                ? (droppedLabel == '5' ? buttonGreen : buttonRed)
                                                : greyColor,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            symbolImages[droppedLabel!]!,
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 61),
                      Wrap(
                        spacing: 10,
                        children: draggableButtons.map((item) {
                          final label = item['label'] as String;
                          final isUsed = usedLabels.contains(label);
                          
                          if (isUsed) {
                            return Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: greyColor, width: 2),
                              ),
                            );
                          }
                          
                          return Draggable<Map<String, dynamic>>(
                            data: item,
                            child: AnimatedButton(
                              width: 60,
                              height: 60,
                              borderRadius: 40,
                              color: Colors.white,
                              onPressed: () {
                                if (droppedLabel == null && !isChecked) {
                                  setState(() {
                                    droppedColor = Colors.white;
                                    droppedLabel = label;
                                    usedLabels.add(label);
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: greyColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    symbolImages[label]!,
                                  ),
                                ),
                              ),
                            ),
                            feedback: Material(
                              color: Colors.transparent,
                              child: AnimatedButton(
                                width: 60,
                                height: 60,
                                borderRadius: 40,
                                color: Colors.white,
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: greyColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      symbolImages[label]!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: greyColor, width: 2),
                              ),
                            ),
                          );
                        }).toList(),
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
                          if (droppedLabel == '5') {
                            submitButtonColor = primaryCorrect;
                            isCorrect = true;
                            widget.onXPUpdate(10);
                            setState(() {
                              GameState.arifmetikaDop += 0.5;
                              GameState.scoreDop += 2;
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
    );
  }
}