import 'package:alochi_math_app/Castles/KvadratQasri.dart';
import 'package:alochi_math_app/Castles/UchburchakPiramidasi.dart';
import 'package:alochi_math_app/UchburchakPiramidasiSavollari/questions1/main_page.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/NotificationsPage.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions1/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions2/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions3/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions4/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions5/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions6/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions7/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions8/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/KvadratQasriSavollari/questions9/main_page9.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/ListOfCastles.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentStageTitle = '';
  String currentStageSubtitle = '';
  String currentCastle = '';
  Color currentStageColor = primaryColor;
  Color currentStageTitleColor = lightblue;

  Timer? countdownTimer;
  int secondsLeft = 60;
  bool _isStageUpdated = false;

  @override
  void initState() {
    super.initState();
    _checkHeartRegeneration();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStageTitle();
    if (!_isStageUpdated) {
      _updateStageTitle();
      _isStageUpdated = true;
    }

    if (GameState.hearts == 0) {
      _checkHeartRegeneration();
    }
  }

  void _updateStageTitle() {
    double progress1 = GameState.currentXP / GameState.maxXP;
    double progress2 = GameState.TcurrentXP / GameState.TmaxXP;

    if (progress1 < 1.0) {
      // Stage 1 — Kvadrat Qasri
      setState(() {
        currentStageTitle = S.of(context).kvadratQasriBirinchiBosqich;
        currentStageSubtitle = S.of(context).kvadratQasriBirinchiBosqichDes;
        currentStageColor = blue;
        currentStageTitleColor = lightBlue;
        currentCastle = S.of(context).squareCastle;
      });
    } else if (progress2 < 1.0) {
      // Stage 2 — Uchburchak Piramidasi
      setState(() {
        currentStageTitle = S.of(context).uchburchakPiramidasiIkkinchiBosqich;
        currentStageSubtitle = S.of(context).uchburchakPiramidasiIkkinchiBosqichDes;
        currentStageColor = red;
        currentStageTitleColor = lightRed;
        currentCastle = S.of(context).squareCastle;
      });
    } else {
      // Stage 3 (or further)
      setState(() {
        currentStageTitle = S.of(context).doiraQasriUchinchiBosqich;
        currentStageSubtitle = S.of(context).doiraQasriUchinchiBosqichDes;
        currentStageColor = Colors.deepOrange;
        currentStageTitleColor = orange;
        currentCastle = S.of(context).squareCastle;
      });
    }
  }

  Future<void> _checkHeartRegeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDepleted = prefs.getInt('heartDepletedTime');

    if (lastDepleted != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsed = now - lastDepleted;
      const delayMillis = 15 * 60 * 1000;

      if (elapsed >= delayMillis) {
        setState(() {
          GameState.hearts = 5;
          secondsLeft = 0;
        });

        prefs.remove('heartDepletedTime');

        // ✅ Save to Firestore
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await GameState.saveState(userId);
        }
      } else {
        secondsLeft = ((delayMillis - elapsed) / 1000).ceil();
        _startCountdown();
      }
    }
  }

  void _startCountdown() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          GameState.hearts = 5;
        });

        // 🔥 FIX: Remove the timestamp after restoring hearts
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('heartDepletedTime');
      }
    });
  }


  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _getCurrentMainPage() {
    if (GameState.currentXP < GameState.maxXP) {
      int index = (GameState.currentXP / (GameState.maxXP / 10)).floor();
      switch (index) {
        case 0: return MainPage1();
        case 1: return MainPage2();
        case 2: return MainPage3();
        case 3: return MainPage4();
        case 4: return MainPage5();
        case 5: return MainPage6();
        case 6: return MainPage7();
        case 7: return MainPage8();
        case 8: return MainPage9();
        default: return MainPage1();
      }
    } else if (GameState.TcurrentXP < GameState.TmaxXP) {
      int index = (GameState.TcurrentXP / (GameState.TmaxXP / 10)).floor();
      switch (index) {
        case 0: return MainPage10();
        case 1: return MainPage2();
        default: return MainPage10();
      }
    } else {
      return const Center(child: Text('Yangi bosqichlar tez orada qo‘shiladi.'));
    }
  }

  Widget _getCurrentCastleWidget() {
    if (GameState.currentXP < GameState.maxXP) {
      return KvadratQasri(
        key: ValueKey(GameState.currentXP), 
        onComplete: () {},
      );
    } else if (GameState.TcurrentXP < GameState.TmaxXP) {
      return UchburchakPiramidasi(
        key: ValueKey(GameState.TcurrentXP),
        onComplete: () {},
      );
    } else {
      return const Text("Yangi qasrlar tez orada qo'shiladi.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconWithValue('assets/icons/Heart.png', '${GameState.hearts}', red),
            _iconWithValue('assets/icons/Diamond.png', '${GameState.gems}', green),
            _iconWithValue('assets/icons/Lightining.png', '${GameState.lightnings}', primaryPurple),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (_, __, ___) => const NotificationsPage(),
                  transitionsBuilder: (_, animation, __, child) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                        .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                    child: child,
                  ),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 🔔 The bell icon
                  Image.asset(
                    'assets/icons/Ring.png',
                    width: 32,
                    height: 32,
                  ),
                  Positioned(
                    top: 0,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                ],
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Top Banner with Levels
                    AnimatedButton(
                      borderRadius: 20,
                      height: screenHeight * 0.10,
                      width: screenWidth * 0.90,
                      color: currentStageColor,
                      onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 600),
                          pageBuilder: (_, __, ___) => const ListOfCastles(),
                          transitionsBuilder: (_, animation, __, child) => SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                                .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                            child: child,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentStageTitle,
                                style: TextStyle(fontSize: 14, color: currentStageTitleColor, fontWeight: FontWeight.bold)),
                            Text(currentStageSubtitle,
                                style: const TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Text above Castles
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: greyColor,
                              thickness: 2,     
                              endIndent: 10,      
                            ),
                          ),
                          Text(
                            currentCastle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: greyColor,
                              thickness: 2,
                              indent: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Castles
                    _getCurrentCastleWidget(),
                    
                    if (GameState.hearts == 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/Heart.png', width: 28, height: 28),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).rechargingIn(_formatTime(secondsLeft)),
                            style: const TextStyle(fontSize: 14, color: red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // Start button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AbsorbPointer(
                absorbing: GameState.hearts == 0,
                child: AnimatedButton(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: GameState.hearts > 0 ? orange : greyColor,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => _getCurrentMainPage()),
                    );

                    if (result == 'xpGained') {
                      setState(() {
                        if (GameState.currentXP < GameState.maxXP) {
                          GameState.currentXP += GameState.maxXP / 10;
                          if (GameState.currentXP > GameState.maxXP) {
                            GameState.currentXP = GameState.maxXP;
                          }
                        } else {
                          GameState.TcurrentXP += GameState.TmaxXP / 10;
                          if (GameState.TcurrentXP > GameState.TmaxXP) {
                            GameState.TcurrentXP = GameState.TmaxXP;
                          }
                        }
                        _updateStageTitle();
                      });

                      // 🔐 Save XP progress to Firestore
                      final userId = FirebaseAuth.instance.currentUser?.uid;
                      if (userId != null) {
                        await GameState.saveState(userId);
                      }

                    } else if (result == 'lostHeart') {
                      if (GameState.hearts > 0) {
                        setState(() => GameState.hearts -= 1);

                        if (GameState.hearts == 0) {
                          final prefs = await SharedPreferences.getInstance();
                          final now = DateTime.now().millisecondsSinceEpoch;
                          await prefs.setInt('heartDepletedTime', now);

                          secondsLeft = 15 * 60;
                          _startCountdown();
                        }

                        // 🔐 Save hearts update to Firestore
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          await GameState.saveState(userId);
                        }
                      }
                    }
                  },
                  child: Text(
                    S.of(context).start,
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithValue(String path, String value, Color color) {
    return Row(
      children: [
        Image.asset(path, width: 32, height: 32),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 18.0,
            fontFamily: primaryFont,
            color: color,
          ),
        ),
      ],
    );
  }
}
