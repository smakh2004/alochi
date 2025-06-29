import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class LevelChoosing extends StatefulWidget {
  final Function(String) onLevelSelected;

  const LevelChoosing({Key? key, required this.onLevelSelected}) : super(key: key);

  @override
  State<LevelChoosing> createState() => _LevelChoosingState();
}

class _LevelChoosingState extends State<LevelChoosing> {
  String? selectedLevel;


  @override
  Widget build(BuildContext context) {
      final List<String> levels = [
        S.of(context).boshlangich,
        S.of(context).yuqoriSinf,
        S.of(context).student,
      ];
    final size = MediaQuery.of(context).size;
    final double buttonWidth = size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.04),

            // Header with Lottie (left) and speech bubble (right)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lottie animation on the left, touching the edge
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(
                    'assets/animations/MrSquareHi.json',
                    fit: BoxFit.cover,
                  ),
                ),

                // Speech bubble aligned to the right
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40, right: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: lightBlue.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                      border: Border.all(color: buttonBlue, width: 1.5),
                    ),
                    child: Text(
                      S.of(context).messageOfMrSquare,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.15),

            // Level buttons
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  final level = levels[index];
                  final isSelected = selectedLevel == level;

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AnimatedButton(
                        height: 60,
                        width: buttonWidth,
                        borderRadius: 12,
                        color: isSelected ? lightBlue : Colors.white,
                        onPressed: () {
                          setState(() {
                            selectedLevel = level;
                          });
                          widget.onLevelSelected(level);
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: isSelected ? buttonBlue : greyColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              level,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
