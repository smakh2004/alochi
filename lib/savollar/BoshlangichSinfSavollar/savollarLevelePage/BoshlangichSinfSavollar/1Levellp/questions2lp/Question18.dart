// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/components/font.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                S.of(context).berilganMisolni,
                style: TextStyle(
                  fontFamily: Font,
                  height: 1.2,
                  fontSize: 26,
                  color: questionColor
                ),
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/question2_images/20coin.png',
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '+',
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    'assets/question2_images/coin10.png',
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '+',
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    'assets/question2_images/coin10.png',
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '+',
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
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
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
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
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    'assets/question2_images/1coin.png',
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '=',
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '51',
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 40,
                                      color: questionColor
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
                                          ? SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: lightGrey,
                                                          borderRadius: BorderRadius.circular(30),
                                                        ),
                                                      ),
                                                      DottedBorder(
                                                        color: candidateData.isNotEmpty
                                                            ? primaryColor
                                                            : greyColor,
                                                        strokeWidth: 3,
                                                        dashPattern: const [10, 4],
                                                        borderType: BorderType.RRect,
                                                        radius: const Radius.circular(30),
                                                        child: const SizedBox(
                                                          width: 58,
                                                          height: 58,
                                                        ),
                                                      ),
                                                    ],
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            isChecked
                ? Container(
                    height: 150,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                              isCorrect
                                  ? S.of(context).togriJavob
                                  : S.of(context).notogriJavob,
                              style: TextStyle(
                                color: isCorrect ? buttonCorrect : red,
                                fontSize: 22,
                                fontFamily: Font,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (isCorrect)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     transitionDuration:
                                  //         const Duration(milliseconds: 600),
                                  //     pageBuilder: (_, __, ___) => const Hint1(),
                                  //     transitionsBuilder:
                                  //         (_, animation, __, child) => SlideTransition(
                                  //       position: Tween<Offset>(
                                  //               begin: const Offset(0, 1),
                                  //               end: Offset.zero)
                                  //           .animate(CurvedAnimation(
                                  //               parent: animation,
                                  //               curve: Curves.easeInOut)),
                                  //       child: child,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                height: 50,
                                width: 120,
                                color: orange,
                                borderRadius: 12,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.lightbulb,
                                        size: 30, color: Colors.white),
                                    Text(
                                      S.of(context).hint,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: Font,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
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
                        width: size.width,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 57),
                            Center(
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: Font,
                                  ),
                                ),
                              ),
                            ),
                          ],
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