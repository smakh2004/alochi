// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/Hint6.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Question6 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question6({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question6> createState() => _Question6State();
}

class _Question6State extends State<Question6> {
  Map<String, String?> droppedLabels = {
    "A": null,
    "B": null,
  };

  Set<String> usedLabels = {};
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  bool isCorrect = false;

  final List<Map<String, dynamic>> draggableButtons = [
    {'color': Colors.white, 'label': '2'},
    {'color': Colors.white, 'label': '3'},
    {'color': Colors.white, 'label': '4'},
    {'color': Colors.white, 'label': '5'},
  ];

  bool get isAnswerSelected =>
      droppedLabels.values.whereType<String>().isNotEmpty;

  void autoDropToFirstAvailableTarget(String label) {
    if (usedLabels.contains(label)) return;

    for (var target in droppedLabels.keys) {
      if (droppedLabels[target] == null) {
        setState(() {
          droppedLabels[target] = label;
          usedLabels.add(label);
        });
        break;
      }
    }
  }

  Widget buildDragTarget(String targetId) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) => !usedLabels.contains(data!['label']),
      onAccept: (data) {
        final label = data['label'] as String;
        setState(() {
          droppedLabels[targetId] = label;
          usedLabels.add(label);
        });
      },
      builder: (context, candidateData, rejectedData) {
        final label = droppedLabels[targetId];

        if (label != null) {
          return AnimatedButton(
            width: 54,
            height: 54,
            color: isChecked
                ? ((label == '2' || label == '4') ? lightGreen : lightRed)
                : Colors.white,
            onPressed: () {
              if (!isChecked) {
                setState(() {
                  droppedLabels[targetId] = null;
                  usedLabels.remove(label);
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isChecked
                    ? ((label == '2' || label == '4') ? buttonGreen : buttonRed)
                    : greyColor, width: 2
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 25,
                    color: questionColor,
                    fontFamily: fontQuestion
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 54,
            width: 54,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                DottedBorder(
                  color: candidateData.isNotEmpty
                      ? primaryColor
                      : greyColor,
                  strokeWidth: 3,
                  dashPattern: const [10, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).berilganMisolniYeching,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: questionColor,
                    ),
                  ),
                ],
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/question_images/Q6.png',
                                    width: 200,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 5),
                                  const Text(
                                    "=",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "8",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  buildDragTarget("A"),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  buildDragTarget("B"),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "=",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "8",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: fontQuestion,
                                      color: questionColor
                                    ),
                                  ),
                                ],
                              ),

                              Spacer(),

                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 10),
                                child: Wrap(
                                  spacing: 10,
                                  children: draggableButtons.map((item) {
                                    final label = item['label'] as String;
                                    final isUsed = usedLabels.contains(label);
                                    
                                    if (isUsed) {
                                      return Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: greyColor, width: 2),
                                        ),
                                      );
                                    }
                                    
                                    return Draggable<Map<String, dynamic>>(
                                      data: item,
                                      child: AnimatedButton(
                                        width: 54,
                                        height: 54,
                                        color: Colors.white,
                                        onPressed: () {
                                          if (!isChecked) {
                                            autoDropToFirstAvailableTarget(label);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: greyColor,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              label,
                                              style: const TextStyle(
                                                fontSize: 25,
                                                color: questionColor,
                                                fontFamily: fontQuestion
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      feedback: Material(
                                        color: Colors.transparent,
                                        child: AnimatedButton(
                                          width: 54,
                                          height: 54,
                                          color: Colors.white,
                                          onPressed: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: greyColor,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                label,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  color: questionColor,
                                                  fontFamily: fontQuestion
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      childWhenDragging: Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: greyColor, width: 2),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
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
                    color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
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
                      const SizedBox(height: 30),
                      if (isCorrect)
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                                    pageBuilder: (_, __, ___) => const Hint6(),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                                // Check both answers
                                if ((droppedLabels["A"] == '2' && droppedLabels["B"] == '4') ||
                                    (droppedLabels["A"] == '4' && droppedLabels["B"] == '2')) {
                                  submitButtonColor = primaryCorrect;
                                  isCorrect = true;
                                  widget.onXPUpdate(10);
                                  setState(() {
                                    GameState.arifmetikaDop += 0.5;
                                    GameState.scoreDop += 3;
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
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
