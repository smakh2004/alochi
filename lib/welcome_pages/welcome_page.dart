// ignore_for_file: depend_on_referenced_packages

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/Student/Student.dart';
import 'package:alochi_math_app/pages/YuqoriSinf/YuqoriSinf.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_1.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_2.dart';
import 'package:alochi_math_app/welcome_pages/intro_page_3.dart';
import 'package:alochi_math_app/welcome_pages/level_choosing.dart';

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

  void _handleButtonPress() {
    if (_currentPage < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else if (GameState.selectedLevel != '') {
      if (GameState.selectedLevel == S.of(context).boshlangich) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BoshlangichSinf()),
        );
      } else if (GameState.selectedLevel == S.of(context).yuqoriSinf) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const YuqoriSinf()),
        );
      } else if (GameState.selectedLevel == S.of(context).student) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Student()),
        );
      }
    }
  }

  void _onLevelSelected(String level) {
    setState(() {
      GameState.selectedLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: [
              const IntroPage1(),
              const IntroPage2(),
              const IntroPage3(),
              LevelChoosing(onLevelSelected: _onLevelSelected),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 40),
            child: AnimatedButton(
              height: 50,
              width: 310,
              color: (_currentPage == 3 && GameState.selectedLevel == '')
                  ? grey
                  : primaryColor,
              onPressed: () {
                if (_currentPage != 3 || GameState.selectedLevel != '') {
                  _handleButtonPress();
                }
              },
              child: Text(
                _currentPage == 3 ? S.of(context).boshlash : S.of(context).davomEtish,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
