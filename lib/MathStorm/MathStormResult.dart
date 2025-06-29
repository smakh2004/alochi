import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class MathStormResult extends StatefulWidget {
  final int score;
  final bool isNewRecord;

  const MathStormResult({
    super.key,
    required this.score,
    required this.isNewRecord,
  });

  @override
  State<MathStormResult> createState() => _MathStormResultState();
}

class _MathStormResultState extends State<MathStormResult>
    with TickerProviderStateMixin {
  bool showSecondAnimation = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.isNewRecord) {
      _controller = AnimationController(vsync: this);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            showSecondAnimation = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.isNewRecord) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.isNewRecord ? S.of(context).yangiRekord : S.of(context).yaxshiUrinish;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Top Animation
            SizedBox(
              height: 350,
              child: Center(
                child: widget.isNewRecord
                    ? showSecondAnimation
                        ? Lottie.asset(
                            'assets/animations/MrSquareFire2.json',
                            height: 500,
                            fit: BoxFit.contain,
                          )
                        : Lottie.asset(
                            'assets/animations/MrSquareFire1.json',
                            height: 500,
                            controller: _controller,
                            onLoaded: (composition) {
                              _controller.duration = composition.duration;
                              _controller.forward();
                            },
                            fit: BoxFit.contain,
                          )
                    : Lottie.asset(
                        'assets/animations/MrSquareStrong.json',
                        height: 550,
                        fit: BoxFit.contain,
                      ),
              ),
            ),

            /// Center Message + Score
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.score}',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w900,
                      color:
                          widget.isNewRecord ? darkOrange : primaryColor,
                    ),
                  ),
                  AnimatedButton(
                    height: 50,
                    width: 200,
                    color: widget.isNewRecord ? darkOrange : primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.isNewRecord
                              ? darkerOrange
                              : borderBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).qaytish,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
}
