// ignore_for_file: use_super_parameters

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

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
                   S.of(context).intro3desc,
                   style: TextStyle(
                     fontFamily: BoldFont,
                     fontSize: 28,
                     color: orange,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).intro3, 
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18, 
                    color: questionColor,
                    fontFamily: Font,
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: size.height * 0.3,
                  child: Image.asset(
                    'assets/images/Welcome3.png',
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