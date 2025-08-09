import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/pages/GameState.dart';

class Question70 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question70({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question70> createState() => _Question70State();
}

class _Question70State extends State<Question70> {
  bool isChecked = false;
  bool isCorrect = false;
  Color submitButtonColor = primaryColor;
  double sliderValue = -8;
  final double minValue = -8;
  final double maxValue = 8;

  ui.Image? _knobImage; // knob image

  bool hasUserInteracted = false;

  bool get isAnswerSelected => hasUserInteracted;

  @override
  void initState() {
    super.initState();
    _loadKnobImage();
  }

  Future<void> _loadKnobImage() async {
    final data = await rootBundle.load('assets/images/Knob.png');
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    setState(() {
      _knobImage = frame.image;
    });
  }

  void _updateValue(Offset localPos, double width) {
    double dx = localPos.dx.clamp(0, width);
    double percent = dx / width;
    double newValue = minValue + (maxValue - minValue) * percent;
    newValue = newValue.roundToDouble();

    // ✅ Fix -0.0 showing
    if (newValue == 0.0 || newValue == -0.0) {
      newValue = 0.0;
    }

    setState(() {
      sliderValue = newValue.clamp(minValue, maxValue);
      hasUserInteracted = true;
    });
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
              child: Text(
                S.of(context).berilganMisollarniYeching,
                style: const TextStyle(
                  fontSize: 26,
                  color: questionColor,
                  fontFamily: Font,
                  height: 1.2,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "3 + 5 = ",
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 40,
                            color: questionColor,
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: lightBlue,
                            border: Border.all(
                              width: 2,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            S.of(context).answer,
                            style: TextStyle(
                              fontFamily: Font,
                              fontSize: 25,
                              color: questionColor,
                              height: 0.5
                            ),
                          ),
                          Text(
                            sliderValue.toStringAsFixed(0),
                            style: TextStyle(
                              fontFamily: Font,
                              fontSize: 35,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onPanStart: (details) {
                          _updateValue(details.localPosition, context.size!.width - 60);
                        },
                        onPanUpdate: (details) {
                          _updateValue(details.localPosition, context.size!.width - 60);
                        },
                        child: CustomPaint(
                          painter: _CustomSliderPainter(
                            value: sliderValue,
                            min: minValue,
                            max: maxValue,
                            knobImage: _knobImage,
                            knobWidth: 40,   // 👈 control width
                            knobHeight: 50,  // 👈 control height
                          ),
                          child: const SizedBox(
                            height: 120,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
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
                              if (sliderValue.round() == 8) {
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

class _CustomSliderPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final ui.Image? knobImage;
  final double knobWidth;
  final double knobHeight;

  _CustomSliderPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.knobImage,
    required this.knobWidth,
    required this.knobHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double trackHeight = 4;
    double dy = size.height / 2;
    double trackPadding = 25;

    Paint inactivePaint = Paint()
      ..color = grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trackHeight;

    Paint activePaint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trackHeight;

    double trackStart = trackPadding;
    double trackEnd = size.width - trackPadding;

    double percent = (value - min) / (max - min);
    double knobX = trackStart + percent * (trackEnd - trackStart);

    // Draw track
    canvas.drawLine(Offset(trackStart, dy), Offset(trackEnd, dy), inactivePaint);
    canvas.drawLine(Offset(trackStart, dy), Offset(knobX, dy), activePaint);

    // Draw ticks for all integers
    for (int i = min.toInt(); i <= max.toInt(); i++) {
      double tickPercent = (i - min) / (max - min);
      double tickX = trackStart + tickPercent * (trackEnd - trackStart);

      bool isEdge = (i == min.toInt() || i == max.toInt());
      double tickHeight = isEdge ? 16 : 8; // small ticks for middle values

      Paint tickPaint = Paint()
        ..color = (i <= value) ? primaryColor : grey
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;

      // Draw the tick
      canvas.drawLine(
        Offset(tickX, dy - tickHeight / 2),
        Offset(tickX, dy + tickHeight / 2),
        tickPaint,
      );

      // Only draw labels for min and max
      if (isEdge) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: i.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: (i <= value) ? primaryColor : grey,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, Offset(tickX - textPainter.width / 2, dy - 40));
      }
    }

    // Draw knob image
    if (knobImage != null) {
      canvas.drawImageRect(
        knobImage!,
        Rect.fromLTWH(0, 0, knobImage!.width.toDouble(), knobImage!.height.toDouble()),
        Rect.fromCenter(center: Offset(knobX, dy + 35), width: knobWidth, height: knobHeight),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CustomSliderPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.knobImage != knobImage ||
        oldDelegate.knobWidth != knobWidth ||
        oldDelegate.knobHeight != knobHeight;
  }
}
