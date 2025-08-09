import 'package:alochi_math_app/welcome_pages/intro_page_10.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_4.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_5.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_6.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_7.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_8.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_9.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_1.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_2.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_3.dart';
import 'package:alochi_math_app/components/color.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final progress = (_currentPage + 1) / 10;
                return Stack(
                  children: [
                    // main progress bar
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progress),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) => LinearProgressIndicator(
                        value: value,
                        borderRadius: BorderRadius.circular(30),
                        minHeight: 16,
                        backgroundColor: greyColor,
                        color: primaryColor,
                      ),
                    ),

                    // highlight line
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progress),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        final fillWidth = constraints.maxWidth * value;
                        // shrink factor
                        final shrinkFactor = 0.5 + (0.9 - 0.5) * value;
                        final highlightWidth = fillWidth * shrinkFactor;

                        return Positioned(
                          left: (fillWidth - highlightWidth) / 2,
                          top: 3.5,
                          child: Container(
                            width: highlightWidth,
                            height: 4.5,
                            decoration: BoxDecoration(
                              color: lighterBlue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: [
          IntroPage1(controller: _controller), // <-- Pass here
          IntroPage2(controller: _controller),
          IntroPage3(controller: _controller),
          IntroPage4(controller: _controller),
          IntroPage5(controller: _controller),
          IntroPage6(controller: _controller),
          IntroPage7(controller: _controller),
          IntroPage8(controller: _controller),
          IntroPage9(controller: _controller),
          IntroPage10(controller: _controller),
        ],
      ),
    );
  }
}
