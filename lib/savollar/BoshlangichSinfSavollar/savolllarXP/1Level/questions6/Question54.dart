import 'dart:math';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';

/// This widget represents one question where user must set the time on a clock.
/// When user drags hour and minute hands to match target time, then presses check,
/// it will show correct/incorrect, update XP, and allow going next.

class Question54 extends StatefulWidget {
  final Function(double) onXPUpdate; // callback to add XP
  final VoidCallback onNext; // callback when pressing continue
  final VoidCallback onIncorrect; // callback when answer is wrong

  const Question54({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question54> createState() => _Question54State();
}

class _Question54State extends State<Question54> {
  // flags for UI
  bool isChecked = false; // did user press check button?
  bool isCorrect = false; // was the answer correct?
  bool answerChosen = false; // has user moved the hands?

  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  /// CHANGE THE CORRECT ANSWER HERE:
  /// These two variables define the target time.
  /// For example, targetHour = 5 and targetMinute = 40 means correct time is 05:40.
  /// Change them to what you want:
  final int targetHour = 12;
  final int targetMinute = 35;
  /// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // initial angles for hands
  double hourAngle = -pi / 2; // hour hand angle
  double minuteAngle = -pi / 2; // minute hand angle
  Offset _center = Offset.zero; // center of clock
  String? activeHand; // currently dragging hour or minute?

  /// Check if the current hand positions equal targetHour and targetMinute
  bool _checkAnswer() {
    // Convert angles to degrees and normalize
    double hourDeg = ((hourAngle * 180 / pi) + 450) % 360;
    double minDeg = ((minuteAngle * 180 / pi) + 450) % 360;

    // Convert degrees to hours and minutes
    int pickedHour = ((hourDeg / 30).round()) % 12;
    if (pickedHour == 0) pickedHour = 12;
    int pickedMinute = ((minDeg / 6).round()) % 60;

    // Compare with target time
    return pickedHour == targetHour && pickedMinute == targetMinute;
  }

  /// Calculate distance from a touch position to a hand to know which hand is closer
  double _distanceToHand(Offset pos, double handAngle, double handLength) {
    final dx = pos.dx - _center.dx;
    final dy = pos.dy - _center.dy;
    final handDx = cos(handAngle);
    final handDy = sin(handAngle);
    final proj = dx * handDx + dy * handDy;
    if (proj < 0 || proj > handLength) return double.infinity;
    final cross = (dx * handDy - dy * handDx).abs();
    return cross;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double clockSize = 310;

    // get picked hour and minute based on angles
    int pickedHour = (((((hourAngle * 180 / pi) + 450) % 360) / 30).round()) % 12;
    if (pickedHour == 0) pickedHour = 12;
    int pickedMinute = (((((minuteAngle * 180 / pi) + 450) % 360) / 6).round()) % 60;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // top section with title and target time
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                   Text(
                    S.of(context).setThisTime, // you can also localize this
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // show the target time
                  Text(
                    "${targetHour.toString().padLeft(1, '0')}:${targetMinute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // clock layout
                  LayoutBuilder(
                    builder: (context, constraints) {
                      _center = Offset(clockSize / 2, clockSize / 2);

                      return GestureDetector(
                        // detect which hand user starts dragging
                        onPanStart: (details) {
                          final RenderBox box = context.findRenderObject() as RenderBox;
                          final local = box.globalToLocal(details.globalPosition);
                          final distHour = _distanceToHand(local, hourAngle, clockSize * 0.3);
                          final distMinute = _distanceToHand(local, minuteAngle, clockSize * 0.45);
                          activeHand = (distHour < distMinute) ? 'hour' : 'minute';
                        },
                        // update hand angle when dragging
                        onPanUpdate: (details) {
                          if (activeHand == null) return;
                          final RenderBox box = context.findRenderObject() as RenderBox;
                          final local = box.globalToLocal(details.globalPosition);
                          setState(() {
                            if (activeHand == 'hour') {
                              hourAngle = atan2(local.dy - _center.dy, local.dx - _center.dx);
                            } else {
                              minuteAngle = atan2(local.dy - _center.dy, local.dx - _center.dx);
                            }
                            answerChosen = true;
                          });
                        },
                        // stop dragging
                        onPanEnd: (_) {
                          activeHand = null;
                        },
                        child: SizedBox(
                          width: clockSize,
                          height: clockSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // clock background (ticks)
                              CustomPaint(
                                size: Size(clockSize, clockSize),
                                painter: _ClockBackgroundPainter(pickedHour, pickedMinute),
                              ),

                              // numbers around
                              for (int i = 1; i <= 12; i++)
                                Builder(builder: (context) {
                                  final angle = (i * 30) * pi / 180 - pi / 2;
                                  final x = clockSize / 2 + (clockSize / 2 - 32) * cos(angle) - 9;
                                  final y = clockSize / 2 + (clockSize / 2 - 32) * sin(angle) - 22;

                                  Color numberColor = grey;
                                  int minuteMark = (pickedMinute ~/ 5 == 0) ? 12 : pickedMinute ~/ 5;

                                  if (i == pickedHour) numberColor = borderBlue;
                                  if (i == minuteMark) numberColor = primaryColor;
                                  if (i == pickedHour && i == minuteMark) numberColor = primaryColor;

                                  return Positioned(
                                    left: x,
                                    top: y,
                                    child: Text(
                                      i.toString(),
                                      style: TextStyle(
                                        fontFamily: BoldFont,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: numberColor,
                                      ),
                                    ),
                                  );
                                }),

                              // hour hand painter
                              CustomPaint(
                                size: Size(clockSize, clockSize),
                                painter: _SingleHandPainter(
                                  hourAngle,
                                  forwardLen: clockSize * 0.25,
                                  backLen: clockSize * 0,
                                  width: 10,
                                  color: borderBlue,
                                ),
                              ),

                              // minute hand painter
                              CustomPaint(
                                size: Size(clockSize, clockSize),
                                painter: _SingleHandPainter(
                                  minuteAngle,
                                  forwardLen: clockSize * 0.32,
                                  backLen: clockSize * 0,
                                  width: 10,
                                  color: primaryColor,
                                ),
                              ),

                              // center pivot circle
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // bottom check area
            isChecked
                // after checking, show result and continue button
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
                                        fontSize: 18,
                                        color: Colors.white,
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
                // before checking, show TEKSHIRISH button
                : AbsorbPointer(
                    absorbing: !answerChosen, // disable if no answer chosen
                    child: Opacity(
                      opacity: answerChosen ? 1.0 : 0.5,
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
                                color: primaryColor,
                                height: 50,
                                width: 310,
                                onPressed: () {
                                  if (!isChecked && answerChosen) {
                                bool correct = _checkAnswer();
                                setState(() {
                                  isCorrect = correct;
                                  isChecked = true;
                                });
                                if (correct) {
                                  widget.onXPUpdate(10); // XP added
                                  setState(() {
                                    GameState.arifmetikaDop += 0.5;
                                    GameState.scoreDop += 1;
                                  });
                                } else {
                                  widget.onIncorrect(); // call incorrect handler
                                }
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

/// Draws the clock face and tick marks
class _ClockBackgroundPainter extends CustomPainter {
  final int pickedHour;
  final int pickedMinute;

  _ClockBackgroundPainter(this.pickedHour, this.pickedMinute);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final facePaint = Paint()
      ..color = const Color(0xFFF9F9F9)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // draw clock circle
    canvas.drawCircle(center, radius, facePaint);
    canvas.drawCircle(center, radius, borderPaint);

    // tick marks
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * pi / 180 - pi / 2;
      final isHourTick = i % 5 == 0;
      final dotRadius = isHourTick ? 3.0 : 1.5;

      // default grey
      Color dotColor = grey;

      int hourPosition = (pickedHour % 12) * 5;
      if (i == hourPosition) dotColor = borderBlue;
      if (i == pickedMinute) dotColor = primaryColor;
      if (i == hourPosition && i == pickedMinute) dotColor = primaryColor;

      final dx = center.dx + (radius - 12) * cos(angle);
      final dy = center.dy + (radius - 12) * sin(angle);

      final dotPaint = Paint()..color = dotColor;
      canvas.drawCircle(Offset(dx, dy), dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ClockBackgroundPainter oldDelegate) {
    return oldDelegate.pickedHour != pickedHour || oldDelegate.pickedMinute != pickedMinute;
  }
}

/// Draws a single clock hand with a triangle tip
class _SingleHandPainter extends CustomPainter {
  final double angle;
  final double forwardLen;
  final double backLen;
  final double width;
  final Color color;

  _SingleHandPainter(
    this.angle, {
    required this.forwardLen,
    required this.backLen,
    required this.width,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // main arrow line
    final paintLine = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    // direction vector
    final dir = Offset(cos(angle), sin(angle));

    // triangle size
    const double triangleLength = 30;
    const double triangleWidth = 40;

    // tip position
    final tip = center + dir * forwardLen;
    final baseCenter = tip - dir * triangleLength;

    // draw line from center to base of triangle
    final start = center - dir * backLen;
    canvas.drawLine(start, baseCenter, paintLine);

    // triangle vertices
    final perp = Offset(-sin(angle), cos(angle));
    final p1 = tip;
    final p2 = baseCenter + perp * (triangleWidth / 2);
    final p3 = baseCenter - perp * (triangleWidth / 2);

    final trianglePath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..close();

    final trianglePaint = Paint()..color = color;
    canvas.drawPath(trianglePath, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
