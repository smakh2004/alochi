// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:dotted_border/dotted_border.dart';

class Question20 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question20({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question20> createState() => _Question20State();
}

class _Question20State extends State<Question20> {
  Color? droppedColor;
  String? droppedLabel;

  final List<Map<String, dynamic>> draggableButtons = [
    {'color': Colors.white, 'label': '10'},
    {'color': Colors.white, 'label': '11'}, 
    {'color': Colors.white, 'label': '12'}, 
    {'color': Colors.white, 'label': '13'}, 
  ];

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              S.of(context).torgaQoshib,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '0, 4, 8, ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                            ),
                          ),
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
                                    )
                                  : AnimatedButton(
                                      width: 60,
                                      height: 60,
                                      color: isChecked
                                      ? (droppedLabel == '12' ? lightGreen : lightRed)
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
                                                ? (droppedLabel == '12' ? buttonGreen : buttonRed)
                                                : greyColor,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            droppedLabel!,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                          if (droppedLabel == '12') {
                            submitButtonColor = primaryCorrect;
                            isCorrect = true;
                            widget.onXPUpdate(10);
                            setState(() {
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
    );
  }
}
