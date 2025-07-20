// ignore_for_file: file_names

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class LoserPage extends StatefulWidget {
  const LoserPage({super.key});

  @override
  State<LoserPage> createState() => _LoserPageState();
}

class _LoserPageState extends State<LoserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // This Expanded takes remaining space and centers the top content vertically
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // shrink to content
                  children: [
                    Lottie.asset(
                      'assets/animations/MrSquareIncorrect.json',
                      height: 250,
                      width: 240,
                    ),
                    Image.asset(
                      'assets/icons/Heart.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      S.of(context).joningiztugadi,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: red,
                        fontFamily: primaryFont,
                      ),
                    ),
                    Text(
                      S.of(context).tanafuzQilib,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: buttonRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ✅ Bottom button stays pinned to bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: AnimatedButton(
                height: 50,
                width: 310,
                color: buttonWrong,
                onPressed: () {
                  Navigator.pop(context, 'lostHeart');
                },
                child: Text(
                  S.of(context).uygaQaytish,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

