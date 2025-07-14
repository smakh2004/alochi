// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Question26 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question26({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question26> createState() => _Question26State();
}

class _Question26State extends State<Question26> {
  Map<String, String?> droppedLabels = {
    "A": null,
    "B": null,
    "C": null,
  };

  Set<String> usedLabels = {};
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  bool isCorrect = false;

  final List<Map<String, dynamic>> draggableButtons = [
    {'color': Colors.white, 'label': '1'},
    {'color': Colors.white, 'label': '7'},
    {'color': Colors.white, 'label': '8'},
    {'color': Colors.white, 'label': '6'},
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
          bool isCorrect = (droppedLabels["A"] == '7' && droppedLabels["B"] == '8' && droppedLabels["C"] == '6');
          Color buttonColor = Colors.white;
          Color borderColor = greyColor;

          if (isChecked) {
            if (isCorrect) {
              buttonColor = lightGreen;
              borderColor = buttonGreen;
            } else {
              buttonColor = lightRed;
              borderColor = buttonRed;
            }
          }

          return AnimatedButton(
            width: 60,
            height: 60,
            color: buttonColor,
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
                  color: isChecked ? borderColor : greyColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          return DottedBorder(
            color: candidateData.isNotEmpty ? primaryColor : grey,
            strokeWidth: 2,
            dashPattern: [13, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              // Removed the Text(targetId) here!
            ),
          );
        }
      },
    );
  }

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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.of(context).berilganMisolniYeching,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "2 + ",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Image.asset(
                            'assets/question3_images/Q26.png',
                            width: size.width * 0.2,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "5 =",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  buildDragTarget("A"),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "6 =",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  buildDragTarget("B"),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "4 =",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  buildDragTarget("C"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
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
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: greyColor, width: 2),
                              ),
                            );
                          }
                          
                          return Draggable<Map<String, dynamic>>(
                            data: item,
                            child: AnimatedButton(
                              width: 60,
                              height: 60,
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            feedback: Material(
                              color: Colors.transparent,
                              child: AnimatedButton(
                                width: 60,
                                height: 60,
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
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                borderRadius: BorderRadius.circular(12),
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Center(
                    child: AnimatedButton(
                      color: submitButtonColor,
                      height: 50,
                      width: 310,
                      onPressed: () {
                        if (!isChecked) {
                          // ✅ Check both answers
                          if ((droppedLabels["A"] == '7' && droppedLabels["B"] == '8' && droppedLabels["C"] == '6')) {
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
