import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'dart:async';

class IntroPage7 extends StatefulWidget {
  final PageController controller;

  const IntroPage7({super.key, required this.controller});

  @override
  State<IntroPage7> createState() => _IntroPage7State();
}

class _IntroPage7State extends State<IntroPage7> with TickerProviderStateMixin {
  late final AnimationController _buttonAnimationController;
  bool _showSecondAnimation = false;

  @override
  void initState() {
    super.initState();

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showSecondAnimation = true;
        });
        _buttonAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animation
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      child: Lottie.asset(
                        'assets/animations/Intro3.json',
                        repeat: true,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Texts
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).learn6xMore,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: Font,
                              fontSize: 27,
                              color: questionColor,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            S.of(context).interactiveLessonsStart,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: Font,
                              fontSize: 18,
                              color: darkGrey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: AnimatedButton(
                    height: 50,
                    width: size.width * 0.8,
                    duration: 100,
                    shadowDegree: ShadowDegree.light,
                    borderRadius: 16,
                    color: _showSecondAnimation ? primaryColor : Colors.grey.shade300,
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
