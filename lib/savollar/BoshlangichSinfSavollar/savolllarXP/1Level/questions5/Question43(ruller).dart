// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';

class Question43 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question43({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question43> createState() => _Question43State();
}

class _Question43State extends State<Question43> {
  bool isChecked = false;
  bool isCorrect = false;
  Color submitButtonColor = primaryColor;

  double knobPosition = 15;
  double rulerWidth = 300;
  double maxValue = 120;
  double targetValue = 30;

  @override
  Widget build(BuildContext context) {
    double selectedValue = ((knobPosition - 24) / (rulerWidth - 48) * maxValue)
    .clamp(0, maxValue)
    .floorToDouble();

    bool isAnswerSelected = knobPosition > 15;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      '${S.of(context).show}${targetValue.toInt()} ${S.of(context).cm}',
                      style: const TextStyle(
                        fontFamily: Font,
                        fontSize: 26,
                        color: questionColor,
                        height: 1.2
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    '${selectedValue.toInt()} cm',
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: Font,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 15),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (isChecked) return; // Don't allow movement after checking
                          setState(() {
                            knobPosition += details.delta.dx;
                            knobPosition = knobPosition.clamp(0, rulerWidth);
                          });
                        },
                        child: SizedBox(
                          width: rulerWidth + 40,
                          height: 140,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Stack(
                                children: [
                                  // Background layer
                                  Positioned(
                                    top: 8,
                                    left: 20,
                                    child: Container(
                                      width: rulerWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: rulerWidth,
                                              height: 70,
                                              color: grey,
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: knobPosition,
                                                height: 70,
                                                color: borderBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Foreground ruler
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      width: rulerWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: rulerWidth,
                                              height: 70,
                                              color: greyColor,
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: knobPosition,
                                                height: 70,
                                                color: primaryColor,
                                              ),
                                            ),
                                            CustomPaint(
                                              size: Size(rulerWidth, 60),
                                              painter: RulerPainter(
                                                maxValue: maxValue,
                                                horizontalPadding: 24,
                                                knobPosition: knobPosition,
                                                rulerWidth: rulerWidth,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Draggable knob
                              Positioned(
                                top: 85,
                                left: knobPosition + 20 - 24,
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (isChecked) return; // Prevent knob from moving after check
                                    setState(() {
                                      knobPosition += details.delta.dx;
                                      knobPosition = knobPosition.clamp(0, rulerWidth);
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/images/Knob.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                ],
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
                              fontFamily: Font,
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
                              borderRadius: 18,
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
                                // Navigator.push(
                                //   context,
                                //   PageRouteBuilder(
                                //     transitionDuration: const Duration(milliseconds: 600),
                                //     pageBuilder: (_, __, ___) => const Hint3(),
                                //     transitionsBuilder: (_, animation, __, child) => SlideTransition(
                                //       position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                                //           .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                                //       child: child,
                                //     ),
                                //   ),
                                // );
                              },
                              height: 50,
                              width: 120, 
                              color: orange,
                              borderRadius: 18,
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
                              borderRadius: 18,
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
                              double selected = ((knobPosition - 24) / (rulerWidth - 48) * maxValue).clamp(0, maxValue);
                              if ((selected - targetValue).abs() <= 1) {
                                submitButtonColor = primaryCorrect;
                                isCorrect = true;
                                widget.onXPUpdate(10);
                                setState(() {
                                  GameState.arifmetikaDop += 0.5;
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
            ),
          ],
        ),
      ),
    );
  }
}

// In the painter:
class RulerPainter extends CustomPainter {
  final double maxValue;
  final double horizontalPadding;
  final double knobPosition;
  final double rulerWidth;

  RulerPainter({
    required this.maxValue,
    required this.horizontalPadding,
    required this.knobPosition,
    required this.rulerWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double effectiveWidth = size.width - 2 * horizontalPadding;

    for (int i = 0; i <= maxValue; i += 10) {
      double x = (i / maxValue) * effectiveWidth + horizontalPadding;
      double lineHeight = i % 20 == 0 ? 16 : 10;

      bool filled = x <= knobPosition;
      Color tickColor = filled ? borderBlue : grey;
      Color textColor = filled ? borderBlue : grey;

      final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round; // Make tick edges circular

    canvas.drawLine(Offset(x, 0), Offset(x, lineHeight), tickPaint);

      if (i % 20 == 0) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: '$i',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontFamily: Font
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, lineHeight + 2));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
