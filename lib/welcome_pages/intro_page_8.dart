import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class IntroPage8 extends StatefulWidget {
  final PageController controller;

  const IntroPage8({super.key, required this.controller});

  @override
  State<IntroPage8> createState() => _IntroPage8State();
}

class _IntroPage8State extends State<IntroPage8> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> options = [
      S.of(context).morningRoutine,
      S.of(context).quickBreak,
      S.of(context).nightlyRitual,
      S.of(context).anotherTime,
    ];

    final List<String> messages = [
      S.of(context).morningMessage,
      S.of(context).quickBreakMessage,
      S.of(context).nightlyMessage,
      S.of(context).anotherTimeMessage,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.35,
                  child: Lottie.asset(
                    'assets/animations/MrSquareHi.json',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: CustomPaint(
                      painter: SpeechBubblePainter(
                        color: const Color(0xFFFFFECF),
                        borderColor: const Color(0xFFF2E44D),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        child: Text(
                          _selectedIndex == null
                              ? S.of(context).chooseBestTime
                              : messages[_selectedIndex!],
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
              ],
            ),

            // Options
            ...List.generate(options.length, (index) {
              final isSelected = _selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? lightBlue : Colors.white,
                      border: Border.all(
                        color: isSelected ? buttonBlue : greyColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: questionColor,
                        fontFamily: Font,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Continue button
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: AnimatedButton(
                height: 50,
                width: size.width * 0.8,
                duration: 100,
                shadowDegree: ShadowDegree.light,
                borderRadius: 16,
                color: _selectedIndex != null ? primaryColor : greyColor,
                onPressed: () {
                  if (_selectedIndex != null) {
                    widget.controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  S.of(context).davomEtish,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: Font,
                    color: Colors.white,
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
    final tailWidth = 12.0;
    final tailHeight = 14.0;

    final path = Path();

    path.moveTo(bubbleRadius + tailWidth, 0);
    path.lineTo(size.width - bubbleRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, bubbleRadius);
    path.lineTo(size.width, size.height - bubbleRadius);
    path.quadraticBezierTo(size.width, size.height, size.width - bubbleRadius, size.height);
    path.lineTo(bubbleRadius + tailWidth, size.height);
    path.quadraticBezierTo(tailWidth, size.height, tailWidth, size.height - bubbleRadius);

    final centerY = size.height / 2;
    path.lineTo(tailWidth, centerY + tailHeight / 2);
    path.lineTo(0, centerY);
    path.lineTo(tailWidth, centerY - tailHeight / 2);

    path.lineTo(tailWidth, bubbleRadius);
    path.quadraticBezierTo(tailWidth, 0, bubbleRadius + tailWidth, 0);

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
