import 'package:alochi_math_app/components/font.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/generated/l10n.dart';

class IntroPage1 extends StatefulWidget {
  final PageController controller;

  const IntroPage1({Key? key, required this.controller}) : super(key: key);

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> with TickerProviderStateMixin {
  late final AnimationController _firstAnimationController;
  late final AnimationController _messageAnimationController;
  late final AnimationController _buttonAnimationController;

  bool _showSecondAnimation = false;
  String _currentMessage = "";

  @override
  void initState() {
    super.initState();

    _firstAnimationController = AnimationController(vsync: this);
    _messageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Initialize first message after build so context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentMessage = S.of(context).hiIamMrSquare;
      });
      _messageAnimationController.forward();
    });

    _firstAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _messageAnimationController.reverse().then((_) {
          setState(() {
            _currentMessage = S.of(context).letsBuildALearningPath;
            _showSecondAnimation = true;
          });
          _messageAnimationController.forward();
          _buttonAnimationController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _firstAnimationController.dispose();
    _messageAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Speech bubble with animated text
                      SizedBox(
                        height: 85,
                        child: AnimatedBuilder(
                          animation: _messageAnimationController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _messageAnimationController.value,
                              child: child,
                            );
                          },
                          child: CustomPaint(
                            painter: SpeechBubblePainter(
                              color: const Color(0xFFFFFECF),
                              borderColor: const Color(0xFFF2E44D),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Text(
                                _currentMessage,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Lottie Animation
                      SizedBox(
                        width: size.width * 0.6,
                        height: size.width * 0.5,
                        child: _showSecondAnimation
                            ? Lottie.asset(
                                'assets/animations/Intro2.json',
                                repeat: true,
                                fit: BoxFit.contain,
                              )
                            : Lottie.asset(
                                'assets/animations/Intro1.json',
                                controller: _firstAnimationController,
                                onLoaded: (composition) {
                                  _firstAnimationController
                                    ..duration = composition.duration
                                    ..forward();
                                },
                                fit: BoxFit.contain,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: FadeTransition(
                opacity: _buttonAnimationController,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(
                        parent: _buttonAnimationController,
                        curve: Curves.easeOutBack),
                  ),
                  child: AnimatedButton(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    duration: 100,
                    shadowDegree: ShadowDegree.light,
                    borderRadius: 16,
                    color: _showSecondAnimation
                        ? primaryColor
                        : Colors.grey.shade300,
                    onPressed: () {
                      if (_showSecondAnimation) {
                        widget.controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      S.of(context).davomEtish,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: Font,
                        color: Colors.white,
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

class SpeechBubblePainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  SpeechBubblePainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final bubbleRadius = 16.0;
    final tailWidth = 16.0;
    final tailHeight = 10.0;

    final path = Path();

    path.moveTo(bubbleRadius, 0);
    path.lineTo(size.width - bubbleRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, bubbleRadius);
    path.lineTo(size.width, size.height - tailHeight - bubbleRadius);
    path.quadraticBezierTo(size.width, size.height - tailHeight,
        size.width - bubbleRadius, size.height - tailHeight);
    path.lineTo((size.width / 2) + (tailWidth / 2), size.height - tailHeight);

    path.lineTo(size.width / 2, size.height);
    path.lineTo(
        (size.width / 2) - (tailWidth / 2), size.height - tailHeight);

    path.lineTo(bubbleRadius, size.height - tailHeight);
    path.quadraticBezierTo(0, size.height - tailHeight, 0,
        size.height - tailHeight - bubbleRadius);
    path.lineTo(0, bubbleRadius);
    path.quadraticBezierTo(0, 0, bubbleRadius, 0);

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
