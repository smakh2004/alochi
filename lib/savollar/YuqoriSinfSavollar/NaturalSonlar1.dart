import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class NaturalSonlar1 extends StatefulWidget {
  const NaturalSonlar1({super.key});

  @override
  State<NaturalSonlar1> createState() => _NaturalSonlar1State();
}

class _NaturalSonlar1State extends State<NaturalSonlar1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).xaliRazrabotkada,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            AnimatedButton(
              height: 50,
              width: 200,
              color: Colors.white,
              borderRadius: 12,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                S.of(context).ortgaQaytish,
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}