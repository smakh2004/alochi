import 'dart:async';
import 'dart:math';
import 'package:alochi_math_app/MathStorm/MathStormSession.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class MathStorm extends StatefulWidget {
  const MathStorm({super.key});

  @override
  State<MathStorm> createState() => _MathStormState();
}

class _MathStormState extends State<MathStorm> {
  int attempts = 3;
  double progress = 1.0;
  DateTime? resetTime;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    checkIfResetNeeded();
    startCountdownTimer();
  }

  void checkIfResetNeeded() {
    final now = DateTime.now();
    final last = GameState.lastLightningDate1;

    if (last == null || now.difference(last).inHours >= 24) {
      GameState.mathStormAttemptsLeft = 3;
      GameState.lastLightningDate1 = now;
    } else if (GameState.mathStormAttemptsLeft == 0) {
      resetTime = last.add(const Duration(hours: 24));
    }

    setState(() {
      attempts = GameState.mathStormAttemptsLeft;
      progress = attempts / 3;
    });
  }

  void startCountdownTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && attempts == 0 && resetTime != null) {
        final now = DateTime.now();
        final diff = resetTime!.difference(now);

        if (diff.isNegative) {
          setState(() {
            GameState.mathStormAttemptsLeft = 3;
            attempts = 3;
            progress = 1.0;
            resetTime = null;
          });
        } else {
          setState(() {}); // Just update timer display
        }
      }
    });
  }

  Future<void> useAttempt() async {
    if (attempts > 0) {
      setState(() {
        GameState.mathStormAttemptsLeft--;
        GameState.lastLightningDate1 = DateTime.now();
        attempts = GameState.mathStormAttemptsLeft;
        progress = attempts / 3;

        if (attempts == 0) {
          resetTime = GameState.lastLightningDate1!.add(const Duration(hours: 24));
        }
      });
    }
  }

  String formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes % 60;
    int seconds = d.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/MathStorm.png',
                      width: double.infinity,
                      height: screenHeight * 0.32,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 2,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).rekord,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            GameState.matematikShtorm.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: const Size(170, 170),
                              painter: DashedCirclePainter(progress),
                            ),
                            Image.asset(
                              'assets/icons/ArifmeticStorm.png',
                              height: 90,
                              width: 90,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${S.of(context).urinishlarSoni} $attempts',
                          style: TextStyle(
                            fontSize: 18,
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (attempts == 0 && resetTime != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '${S.of(context).yangiUrinishlar} ${formatDuration(resetTime!.difference(DateTime.now()))} ${S.of(context).danSong}',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: grey, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/StormTime.png', height: 32, width: 32),
                                const SizedBox(width: 5),
                                Text('3 ${S.of(context).minut}', style: TextStyle(fontSize: 18, color: darkOrange, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 24),
                                Image.asset('assets/icons/Heart.png', height: 32, width: 32),
                                const SizedBox(width: 5),
                                Text('3 ${S.of(context).dona}', style: TextStyle(fontSize: 18, color: red, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AnimatedButton(
                    width: screenWidth * 0.5,
                    height: 50,
                    color: attempts > 0 ? red : greyColor,
                    onPressed: () async {
                      if (attempts > 0) {
                        useAttempt();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MathStormSession()),
                        );
                        setState(() {});
                      }
                    },
                    child: Text(
                      S.of(context).olga,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final double progress;
  DashedCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final totalSegments = 3;
    final gapAngle = pi / 8;

    final paint = Paint()
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < totalSegments; i++) {
      final isActive = i < (progress * totalSegments).floor();
      paint.color = isActive ? orange : greyColor;

      final startAngle = (2 * pi / totalSegments) * i;
      final sweepAngle = (2 * pi / totalSegments) - gapAngle;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}