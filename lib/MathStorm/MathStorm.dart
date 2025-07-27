import 'dart:async';
import 'dart:math';
import 'package:alochi_math_app/MathStorm/MathStormSession.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

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

  late Future<void> _loadGameStateFuture;

  @override
  void initState() {
    super.initState();
    _loadGameStateFuture = _initializeState(); // wait for firestore load
  }

  Future<void> _initializeState() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await GameState.loadState(userId); // 🔄 Load actual user values
    }
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

    attempts = GameState.mathStormAttemptsLeft;
    progress = attempts / 3;
  }

  void startCountdownTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
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

          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            await GameState.saveState(userId);
          }
        } else {
          setState(() {}); // update countdown
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

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await GameState.saveState(userId);
      }
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
    return FutureBuilder(
      future: _loadGameStateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return _buildMainContent(context);
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [ 
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 270, // total area height
                            width: double.infinity,
                            child: Stack(
                              children: [
                                // BACKGROUND: two colors
                                Column(
                                  children: [
                                    Container(height: 215, color: redDark),
                                  ],
                                ),

                                // FOREGROUND: animation
                                Center(
                                  child: SizedBox(
                                    height: 250, // animation size
                                    child: Lottie.asset(
                                      'assets/animations/MathStormAnimation.json',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                // FOREGROUND: bottom text
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).rekord,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontFamily: Font,
                                          color: questionColor
                                        ),
                                      ),
                                      Text(
                                        GameState.matematikShtorm.toString(),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontFamily: Font,
                                          color: red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(150, 150),
                                painter: DashedCirclePainter(progress),
                              ),
                              Image.asset(
                                'assets/icons/ArifmeticStorm.png',
                                height: 80,
                                width: 80,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${S.of(context).urinishlarSoni} $attempts',
                            style: TextStyle(
                              fontSize: 18,
                              color: orange,
                              fontFamily: Font,
                            ),
                          ),
                          if (attempts == 0 && resetTime != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                '${S.of(context).yangiUrinishlar} ${formatDuration(resetTime!.difference(DateTime.now()))} ${S.of(context).danSong}',
                                style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: Font,),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: greyColor, width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/StormTime.png', height: 32, width: 32),
                                  const SizedBox(width: 5),
                                  Text('3 ${S.of(context).minut}',
                                      style: TextStyle(fontSize: 18, color: darkOrange, fontFamily: Font,)),
                                  const SizedBox(width: 24),
                                  Image.asset('assets/icons/Heart.png', height: 32, width: 32),
                                  const SizedBox(width: 5),
                                  Text('3 ${S.of(context).dona}',
                                      style: TextStyle(fontSize: 18, color: red, fontFamily: Font,)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AnimatedButton(
                    width: screenWidth * 0.5,
                    height: 50,
                    color: attempts > 0 ? red : greyColor,
                    borderRadius: 16,
                    onPressed: () async {
                      if (attempts > 0) {
                        await useAttempt();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MathStormSession()),
                        );
                        setState(() {}); // Refresh UI after returning
                      }
                    },
                    child: Text(
                      S.of(context).olga,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: Font,
                        fontSize: 18,
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