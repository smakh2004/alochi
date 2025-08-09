// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Hint1.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class Question60 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question60({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question60> createState() => _Question60State();
}

class _Question60State extends State<Question60> {
  bool isChecked = false;
  bool isCorrect = false;
  Color submitButtonColor = primaryColor;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Berilgan misollarni yeching va qanday ism kelib chiqkanini yozing!',
                style: const TextStyle(
                  fontSize: 26,
                  color: questionColor,
                  fontFamily: Font,
                  height: 1.2,
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'o) ',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '55-46',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'r) ',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '11+6',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'n) ',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '101-99+9',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'a) ',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '98-84',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 2)
                                          ),
                                        ),
                                        Text(
                                          '=14',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 2)
                                          ),
                                        ),
                                        Text(
                                          '=11',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 2)
                                          ),
                                        ),
                                        Text(
                                          '=9',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor, width: 2)
                                          ),
                                        ),
                                        Text(
                                          '=17',
                                          style: TextStyle(
                                            color: questionColor,
                                            fontFamily: Font,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            isChecked
                ? Container(
                    height: 210,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? buttonCorrect : red,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCorrect ? S.of(context).togriJavob : S.of(context).notogriJavob,
                              style: TextStyle(
                                color: isCorrect ? buttonCorrect : red,
                                fontSize: 22,
                                fontFamily: Font,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            controller: controller,
                            readOnly: true,
                            style: TextStyle(
                              color: isCorrect ? buttonCorrect : red,
                              fontSize: 20,
                              fontFamily: Font,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: lightGrey, 
                              hintText: 'Ismni kiriting',
                              hintStyle: TextStyle(color: isCorrect ? buttonCorrect : red, fontFamily: Font,),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: isCorrect ? buttonCorrect : red, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: isCorrect ? buttonCorrect : red, width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (isCorrect)
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: AnimatedButton(
                                onPressed: widget.onNext,
                                color: buttonCorrect,
                                height: 50,
                                width: 310,
                                borderRadius: 12,
                                child: Text(
                                  S.of(context).davomEtish,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: Font,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 600),
                                      pageBuilder: (_, __, ___) => const Hint1(),
                                      transitionsBuilder: (_, animation, __, child) => SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeInOut,
                                          ),
                                        ),
                                        child: child,
                                      ),
                                    ),
                                  );
                                },
                                height: 50,
                                width: 120,
                                color: orange,
                                borderRadius: 12,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.lightbulb, size: 30, color: Colors.white),
                                    Text(
                                      S.of(context).hint,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: Font,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              AnimatedButton(
                                onPressed: widget.onNext,
                                color: red,
                                height: 50,
                                width: 160,
                                borderRadius: 12,
                                child: Text(
                                  S.of(context).davomEtish,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: Font,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                : Container(
                    height: 325,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            controller: controller,
                            readOnly: true,
                            style: const TextStyle(
                              color: questionColor,
                              fontSize: 20,
                              fontFamily: Font,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: lightGrey, 
                              hintText: 'Ismni kiriting',
                              hintStyle: const TextStyle(color: greyColor, fontFamily: Font,),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: greyColor, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: greyColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i in ['a', 'b', 'c']) _buildNumberButton(i.toString()),
                            _buildBackspaceButton(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i in ['k', 'm', 'n', 'i']) _buildNumberButton(i.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i in ['p', 'o', 'r', 's']) _buildNumberButton(i.toString()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: AnimatedButton(
                            color: submitButtonColor,
                            height: 50,
                            width: 310,
                            onPressed: () {
                              if (!isChecked) {
                                final userInput = controller.text.trim().toUpperCase();
                                if (userInput == 'ANOR') {
                                  submitButtonColor = primaryCorrect;
                                  isCorrect = true;
                                  widget.onXPUpdate(10);
                                  setState(() {
                                    GameState.arifmetikaDop += 0.5;
                                    GameState.scoreDop += 2;
                                  });
                                } else {
                                  submitButtonColor = primaryIncorrect;
                                  isCorrect = false;
                                  widget.onXPUpdate(5);
                                  widget.onIncorrect();
                                }
                                setState(() {
                                  isChecked = true;
                                });
                              }
                            },
                            child: Text(
                              S.of(context).tekshirish,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: Font,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedButton(
        width: 65,
        height: 42,
        color: Colors.white,
        onPressed: () {
          setState(() {
            controller.text += number;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: greyColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 24,
                fontFamily: Font,
                color: questionColor
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedButton(
        width: 65,
        height: 42,
        color: primaryColor,
        onPressed: () {
          setState(() {
            if (controller.text.isNotEmpty) {
              controller.text = controller.text.substring(0, controller.text.length - 1);
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderBlue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            )
          ),
        ),
      ),
    );
  }
}
