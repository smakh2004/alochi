import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Hint8 extends StatefulWidget {
  const Hint8({super.key});

  @override
  State<Hint8> createState() => _Hint8State();
}

class _Hint8State extends State<Hint8> {
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
            Text(S.of(context).hint, style: TextStyle(fontFamily: primaryFont, color: darkGrey)),
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
      body: Column(

      )
    );
  }
}