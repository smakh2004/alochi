import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Hint4 extends StatefulWidget {
  const Hint4({super.key});

  @override
  State<Hint4> createState() => _Hint4State();
}

class _Hint4State extends State<Hint4> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).hint4,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Font,
                  color: darkGrey,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/images/Hint(visualProblems).png',
                  width: 350,
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}