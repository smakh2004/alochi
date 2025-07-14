// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Question21 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question21({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question21> createState() => _Question21State();
}

class _Question21State extends State<Question21> {
  Map<String, String?> droppedLabels = {
    "A": null,
    "B": null,
  };

  Set<String> usedLabels = {};
  bool isChecked = false;
  Color submitButtonColor = primaryColor;
  bool isCorrect = false;

  final List<Map<String, dynamic>> draggableButtons = [
    {'color': Colors.white, 'label': '1'},
    {'color': Colors.white, 'label': '2'},
    {'color': Colors.white, 'label': '3'},
    {'color': Colors.white, 'label': '4'},
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
            width: 60,
            height: 60,
            color: isChecked
                ? ((label == '1' || label == '3') ? lightGreen : lightRed)
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
                    ? ((label == '1' || label == '3') ? buttonGreen : buttonRed)
                    : greyColor, width: 2
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
                      const SizedBox(height: 40),
                          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/question3_images/Q21.png',
                            width: size.width * 0.65,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          const Text(
                            "= 8",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                          
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 1),
                          buildDragTarget("A"),
                          const Text(
                            " +1",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 1),
                          const Text(
                            "+",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 1),
                          const Text(
                            "3+",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                          buildDragTarget("B"),
                          const SizedBox(width: 5),
                          const Text(
                            "=8",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                            // Check both answers
                            if ((droppedLabels["A"] == '1' && droppedLabels["B"] == '3') ||
                                (droppedLabels["A"] == '3' && droppedLabels["B"] == '1')) {
                              submitButtonColor = primaryCorrect;
                              isCorrect = true;
                              widget.onXPUpdate(10);
                              setState(() {
                                GameState.arifmetikaDop = 0;
                                GameState.logikaDop = 0;
                                GameState.scoreDop = 0;
                                GameState.arifmetikaDop += 0.5;
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
              )
          ],
        ),
      ),
    );
  }
}
