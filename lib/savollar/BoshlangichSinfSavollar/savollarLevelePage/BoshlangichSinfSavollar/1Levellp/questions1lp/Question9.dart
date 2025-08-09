// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/Hint9.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class Question9 extends StatefulWidget {
  final Function(double) onXPUpdate;
  final VoidCallback onNext;
  final VoidCallback onIncorrect;

  const Question9({
    super.key,
    required this.onXPUpdate,
    required this.onNext,
    required this.onIncorrect,
  });

  @override
  State<Question9> createState() => _Question9State();
}

class _Question9State extends State<Question9> {
  bool get isAnswerSelected => knightX != initialX || knightY != initialY;

  // Original coordinate system: 3 cols × 2 rows
  final int initialX = 2; // original column index for knight start
  final int initialY = 1; // original row index for knight start

  int knightX = 2;
  int knightY = 1;

  bool isChecked = false;
  bool isCorrect = false;
  Color submitButtonColor = primaryColor;

  final int goalX = 0; // original column index for goal (top-left corner)
  final int goalY = 0; // original row index for goal

  final double boxSize = 90;

  // Visited positions in original coordinates
  Set<Offset> visitedPositions = {};

  // Rotated grid dimensions (2 cols × 3 rows)
  final int columns = 2;
  final int rows = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                S.of(context).otniTogri,
                style: TextStyle(
                  fontFamily: Font,
                  fontSize: 26,
                  color: questionColor,
                  height: 1.2
                ),
              ),
            ),
            const SizedBox(height: 40),
        
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Center(
                                child: Container(
                                  width: boxSize * columns,
                                  height: boxSize * rows,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: grey, width: 2),
                                  ),
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: columns * rows,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: columns,
                                    ),
                                    itemBuilder: (context, index) {
                                      // Compute rotated grid coordinates (x, y)
                                      int x = index % columns; // column in rotated grid (0 or 1)
                                      int y = index ~/ columns; // row in rotated grid (0 to 2)
                                
                                      // Map rotated coords back to original coords:
                                      // original column = y (row in rotated)
                                      // original row = x (col in rotated)
                                      int origX = y; // original column
                                      int origY = x; // original row
                                
                                      bool isKnight = knightX == origX && knightY == origY;
                                
                                      // Decide tile color using original coords for checkerboard
                                      Color tileColor;
                                      if (isChecked && isKnight) {
                                        tileColor = isCorrect ? buttonGreen : buttonRed;
                                      } else if (visitedPositions.contains(Offset(origX.toDouble(), origY.toDouble()))) {
                                        tileColor = buttonBlue;
                                      } else {
                                        tileColor = (origX + origY) % 2 == 0 ? grey : Colors.white;
                                      }
                                
                                      // Allow drag only if knight at initial position and not checked
                                      bool canDragFromHere = !isChecked && (knightX == initialX && knightY == initialY);
                                
                                      return DragTarget<Offset>(
                                        onWillAccept: (data) => !isChecked,
                                        onAccept: (data) {
                                          if (!isChecked && (origX != knightX || origY != knightY)) {
                                            setState(() {
                                              knightX = origX;
                                              knightY = origY;
                                              visitedPositions.add(Offset(origX.toDouble(), origY.toDouble()));
                                            });
                                          }
                                        },
                                        builder: (context, candidateData, rejectedData) {
                                          return Container(
                                            width: boxSize,
                                            height: boxSize,
                                            margin: const EdgeInsets.all(2),
                                            color: tileColor,
                                            child: Center(
                                              child: isKnight
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        if (!isChecked &&
                                                            (knightX != initialX || knightY != initialY)) {
                                                          setState(() {
                                                            // Reset knight position and visited cells
                                                            knightX = initialX;
                                                            knightY = initialY;
                                                            visitedPositions.clear();
                                                          });
                                                        }
                                                      },
                                                      child: Draggable<Offset>(
                                                        data: Offset(origX.toDouble(), origY.toDouble()),
                                                        feedback: knightWidget(),
                                                        childWhenDragging: const SizedBox.shrink(),
                                                        child: knightWidget(),
                                                        maxSimultaneousDrags: canDragFromHere ? 1 : 0,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
        
              isChecked
                ? Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: isCorrect ? lightGreen : const Color(0xFFFFE4E1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top row with icon and "Correct/Incorrect"
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
                      const SizedBox(height: 30),
                      if (isCorrect)
                        // Only Davom Etish button with full width
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
                        // Incorrect answer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(milliseconds: 600),
                                    pageBuilder: (_, __, ___) => const Hint9(),
                                    transitionsBuilder: (_, animation, __, child) => SlideTransition(
                                      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                                          .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
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
                                  Icon(Icons.lightbulb, size: 30, color: Colors.white),
                                  Text(
                                    S.of(context).hint,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: Font,
                                    ),
                                  ),
                                  SizedBox(width: 6),
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
            : AbsorbPointer(
                absorbing: !isAnswerSelected,
                child: Opacity(
                  opacity: !isAnswerSelected ? 0.5 : 1,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 57),
                          AnimatedButton(
                            color: submitButtonColor,
                            height: 50,
                            width: 310,
                            onPressed: () {
                              if (!isChecked) {
                                bool correctNow = knightX == goalX && knightY == goalY;
                                setState(() {
                                  isChecked = true;
                                  isCorrect = correctNow;
                                              
                                  if (correctNow) {
                                    submitButtonColor = primaryCorrect;
                                    widget.onXPUpdate(10);
                                  } else {
                                    submitButtonColor = primaryIncorrect;
                                    widget.onXPUpdate(5);
                                    widget.onIncorrect();
                                  }
                                });
                              }
                            },
                            child: Text(
                              S.of(context).tekshirish,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: Font,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget knightWidget() {
    return Image.asset(
      'assets/question_images/knight.png',
      width: 60,
      height: 60,
    );
  }
}
