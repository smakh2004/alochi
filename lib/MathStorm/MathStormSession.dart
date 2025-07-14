import 'dart:async';
import 'package:alochi_math_app/MathStorm/MathStormResult.dart';
import 'package:alochi_math_app/MathStorm/math_problem.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../MathStorm/problem_generator.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/generated/l10n.dart';

class MathStormSession extends StatefulWidget {
  const MathStormSession({super.key});

  @override
  State<MathStormSession> createState() => _MathStormSessionState();
}

class _MathStormSessionState extends State<MathStormSession> {
  bool isAnswerValid = false;
  
  late Timer timer;
  int timeLeft = 180;
  int score = 0;
  int hearts = 3;
  late MathProblem currentProblem;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentProblem = ProblemGenerator.generate(score);
    startTimer();

    controller.addListener(() {
      setState(() {
        final text = controller.text.trim();
        isAnswerValid = int.tryParse(text) != null;
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => timeLeft--);
      if (timeLeft <= 0) {
        timer.cancel();
        endSession();
      }
    });
  }

  void submitAnswer() {
    final input = int.tryParse(controller.text);
    if (input != null && input == currentProblem.answer) {
      setState(() => score++);
    } else {
      setState(() => hearts--);
      if (hearts <= 0) {
        timer.cancel();
        endSession();
        return;
      }
    }
    controller.clear();
    setState(() => currentProblem = ProblemGenerator.generate(score));
  }

  Future<void> endSession() async {
    GameState.lastScore = score;
    GameState.lastTime = 180 - timeLeft;

    final isNewRecord = score > GameState.matematikShtorm;
    if (isNewRecord) {
      GameState.matematikShtorm = score;
    }

    // Get userId
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      await GameState.saveState(userId);
    } else {
      print("User is not logged in; game state not saved.");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MathStormResult(
          score: score,
          isNewRecord: isNewRecord,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animations/MrSquareCrying.json',
                      height: 180,
                      width: 170,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      S.of(context).agarChiqibKetsangiz,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedButton(
                      height: 45,
                      width: 270,
                      color: primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).darsDavomEtish,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedButton(
                    height: 45,
                    width: 270,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).chiqish,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
            ],
          ),
        );
      },
    );
    return false;
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int min = timeLeft ~/ 60;
    int sec = timeLeft % 60;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 60,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/StormTime.png', height: 35, width: 35),
                    const SizedBox(width: 4),
                    Text(
                      "$min:${sec.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 20, color: darkOrange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text("${S.of(context).Ochko} $score",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Image.asset(
                        'assets/icons/Heart.png',
                        width: 26,
                        height: 26,
                        color: index < hearts ? null : Colors.grey.withOpacity(0.4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3.0),
            child: Container(color: greyColor, height: 2.0),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  S.of(context).javobKiriting,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${currentProblem.question} = ",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        width: 320,
                        child: TextField(
                          controller: controller,
                          readOnly: true,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: lightGrey, 
                            hintText: S.of(context).misolUchun,
                            hintStyle: const TextStyle(color: greyColor), // Hint color
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
                    ),
                  SizedBox(height: 20),
                  Container(color: greyColor, width: double.infinity, height: 2.0),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i in [1, 2, 3]) _buildNumberButton(i.toString()),
                      _buildBackspaceButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i in [4, 5, 6]) _buildNumberButton(i.toString()),
                      _buildMinusButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i in [7, 8, 9]) _buildNumberButton(i.toString()),
                      _buildNumberButton('0'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedButton(
                    width: 310,
                    height: 50,
                    color: isAnswerValid ? primaryColor : lightGrey,
                    onPressed: () {
                      if (isAnswerValid) {
                        submitAnswer();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isAnswerValid ? borderBlue : greyColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).keyingi,
                          style: TextStyle(
                            color: isAnswerValid ? Colors.white : grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedButton(
        width: 70,
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
        width: 70,
        height: 42,
        color: lightGrey,
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
              color: greyColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.backspace
            )
          ),
        ),
      ),
    );
  }

  Widget _buildMinusButton() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedButton(
        width: 70,
        height: 42,
        color: primaryColor,
        onPressed: () {
          setState(() {
            if (!controller.text.contains('-')) {
              controller.text = '-' + controller.text;
            } else if (controller.text.startsWith('-')) {
              controller.text = controller.text.substring(1); // Toggle minus
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
          child: const Center(
            child: Text(
              '-',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}