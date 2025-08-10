import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class IntroPage6 extends StatefulWidget {
  final PageController controller;

  const IntroPage6({super.key, required this.controller});

  @override
  State<IntroPage6> createState() => _IntroPage6State();
}

class _IntroPage6State extends State<IntroPage6> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  int? _selectedIndex;

  final List<String> _options = [
    "5 min",
    "10 min",
    "15 min",
    "20 min"
  ];

  // Unique icons for each goal
  final List<IconData> _optionIcons = [
    Icons.timer,          // 5 min
    Icons.av_timer,       // 10 min
    Icons.schedule,       // 15 min
    Icons.timelapse,    // 20 min
  ];

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animation
                SizedBox(
                  height: size.width * 0.35,
                  child: Lottie.asset(
                    'assets/animations/MrSquareHi.json',
                  ),
                ),
            
                // Speech bubble
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
                          S.of(context).dailyGoal,
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

            // Options with icons
            ...List.generate(_options.length, (index) {
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
                    child: Row(
                      children: [
                        Icon(
                          _optionIcons[index],
                          color: isSelected ? buttonBlue : greyColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: questionColor,
                              fontFamily: Font,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
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

    // Start from top-left rounded corner (after tail)
    path.moveTo(bubbleRadius + tailWidth, 0);
    path.lineTo(size.width - bubbleRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, bubbleRadius);
    path.lineTo(size.width, size.height - bubbleRadius);
    path.quadraticBezierTo(size.width, size.height, size.width - bubbleRadius, size.height);
    path.lineTo(bubbleRadius + tailWidth, size.height);
    path.quadraticBezierTo(tailWidth, size.height, tailWidth, size.height - bubbleRadius);

    // Tail on left-center
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
