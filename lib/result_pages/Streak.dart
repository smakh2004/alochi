// ignore_for_file: file_names, use_build_context_synchronously
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class Streak extends StatefulWidget {
  const Streak({super.key});

  @override
  State<Streak> createState() => _StreakState();
}

class _StreakState extends State<Streak> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _updateStreak();
  }

  void _updateStreak() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    GameState.streakDates;

    if (!GameState.streakDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day)) {
      GameState.streakDates.add(today);
    }

    GameState.streakDates.removeWhere((d) => today.difference(d).inDays > 6);

    GameState.lightnings++;
    GameState.lastLightningDate = now;

    final user = FirebaseAuth.instance.currentUser;
    if (user?.uid != null) {
      GameState.saveState(user!.uid);
    }

    setState(() {});
  }

  Widget _buildDay(bool ticked, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: ticked ? primaryPurple : grey
            ),
            borderRadius: BorderRadius.circular(40),
            color: ticked ? lightPurple : null
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ticked 
            ? Image.asset('assets/icons/Lightining2.png', width: 15, height: 15,) 
            : Image.asset('assets/icons/Lightining3.png', width: 15, height: 15),
          )
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: Font,
            fontSize: 16,
            fontWeight: ticked ? FontWeight.bold : FontWeight.normal,
            color: ticked ? questionColor : darkGrey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Weekday labels
    List<String> allDays = [
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wed,
      S.of(context).thu,
      S.of(context).fri,
      S.of(context).sat,
      S.of(context).sun
    ];

    // Rotate so last item is today
    List<String> getShiftedDays() {
      int todayIndex = DateTime.now().weekday - 1;
      return List.generate(7, (i) {
        int index = (todayIndex - (6 - i)) % 7;
        if (index < 0) index += 7;
        return allDays[index];
      });
    }

    List<String> daysLabels = getShiftedDays();

    // Generate ticked status for each day in the last 7 days
    DateTime today = DateTime.now();
    List<bool> tickedDays = List.generate(7, (i) {
      DateTime day = today.subtract(Duration(days: 6 - i));
      return GameState.streakDates.any((d) =>
          d.year == day.year && d.month == day.month && d.day == day.day);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/animations/MrSquareStreak.json',
                          height: 250,
                          width: 240,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            GameState.lightnings.toString(),
                            style: TextStyle(
                              fontSize: 85,
                              color: questionColor,
                              fontFamily: BoldFont,
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset('assets/icons/Lightining.png', width: 45, height: 45,)
                        ],
                      ),
                      Text(
                        S.of(context).davomiyYutuq,
                        style: TextStyle(
                          fontSize: 24,
                          color: primaryPurple,
                          fontFamily: BoldFont,
                        ),
                      ),
                      Text(
                        S.of(context).sizniErtagaKutamiz,
                        style: TextStyle(
                          fontFamily: Font,
                          fontSize: 18,
                          color: questionColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(7, (i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: _buildDay(tickedDays[i], daysLabels[i]),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: AnimatedButton(
                  height: 50,
                  width: 310,
                  color: primaryPurple,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const BoshlangichSinf()),
                    );
                  },
                  child: Text(
                    S.of(context).uygaQaytish,
                    style: TextStyle(
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
      ),
    );
  }
}
