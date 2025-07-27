import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Hint1 extends StatefulWidget {
  const Hint1({super.key});

  @override
  State<Hint1> createState() => _Hint1State();
}

class _Hint1State extends State<Hint1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(S.of(context).hint, style: TextStyle(fontFamily: BoldFont, color: darkGrey)),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.expand_more, color: darkGrey, size: 35)
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Lottie.asset(
                'assets/animations/Hint.json',
                fit: BoxFit.contain,
                height: 70,
                width: 40
              ),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).hint1,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Font,
                  color: darkGrey,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/Hint1.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}