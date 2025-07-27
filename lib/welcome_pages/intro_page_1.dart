// ignore_for_file: use_super_parameters

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  'A\'LOCHI',
                  style: TextStyle(
                    fontFamily: BoldFont,
                    fontSize: 28,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).intro,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18, 
                    fontFamily: Font,
                    color: questionColor
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: size.height * 0.3,
                  child: Image.asset(
                    'assets/images/Welcome1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 60), // Reserve space at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
