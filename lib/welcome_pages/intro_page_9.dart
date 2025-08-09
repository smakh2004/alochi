import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alochi_math_app/components/color.dart'; 
import 'package:animated_button/animated_button.dart';

class IntroPage9 extends StatefulWidget {
  final PageController controller;

  const IntroPage9({super.key, required this.controller});

  @override
  State<IntroPage9> createState() => _IntroPage9State();
}

class _IntroPage9State extends State<IntroPage9> with TickerProviderStateMixin {
  late final AnimationController _buttonAnimationController;
  late final AnimationController _firstLottieController;
  bool _showSecondAnimation = false;

  @override
  void initState() {
    super.initState();

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _firstLottieController = AnimationController(vsync: this);
    
    _firstLottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
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
    _firstLottieController.dispose();
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
                    // Animated Box
                    SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      child: _showSecondAnimation
                          ? Lottie.asset(
                              'assets/animations/Intro6.json',
                              repeat: true,
                              fit: BoxFit.contain,
                            )
                          : Lottie.asset(
                              'assets/animations/Intro5.json',
                              controller: _firstLottieController,
                              onLoaded: (composition) {
                                _firstLottieController
                                  ..duration = composition.duration
                                  ..forward();
                              },
                              fit: BoxFit.contain,
                            ),
                    ),

                    // Texts
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).getRewardsForStudy,
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
                            S.of(context).alochiKeepsYouOnTrack,
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
                      style: TextStyle(
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
