import 'package:alochi_math_app/pages/BoshlangichSinf/Castles/KvadratQasri.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/Castles/UchburchakPiramidasi.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/LevelPage2.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/LevelPage3.dart';
import 'package:alochi_math_app/pages/Connectivity.dart';
import 'package:alochi_math_app/pages/NoInternetPage.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions10/main_page.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/LevelPage.dart';
import 'package:alochi_math_app/pages/NotificationsPage.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions1/main_page.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions2/main_page2.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions3/main_page3.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions4/main_page4.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions5/main_page5.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions6/main_page6.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions7/main_page7.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions8/main_page8.dart';
import 'package:alochi_math_app/savollar/BoshlangichSinfSavollar/savolllarXP/1Level/questions9/main_page9.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';
import 'package:provider/provider.dart';
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
  int currentCastleIndex = 0;

  Timer? countdownTimer;
  int secondsLeft = 60;
  bool _isStageUpdated = false;

  @override
  void initState() {
    super.initState();

    _checkHeartRegeneration();
    _checkLightningTimeout();

    // Determine initial castle index
    int initialCastleIndex = 0;
    if (GameState.currentXP >= GameState.maxXP && GameState.currentXP2 < GameState.maxXP2) {
      initialCastleIndex = 1;
    } else if (GameState.currentXP2 >= GameState.maxXP2 && GameState.currentXP3 < GameState.maxXP3) {
      initialCastleIndex = 2;
    } else if (GameState.currentXP3 >= GameState.maxXP3 && GameState.currentXP4 < GameState.maxXP4) {
      initialCastleIndex = 3;
    }

    // Set the correct title/subtitle immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (initialCastleIndex == 0) {
          currentStageTitle = S.of(context).kvadratQasriBirinchiBosqich;
          currentStageSubtitle = S.of(context).kvadratQasriBirinchiBosqichDes;
          currentStageColor = blue;
          currentStageTitleColor = lightBlue;
          currentCastle = S.of(context).squareCastle;
        } else if (initialCastleIndex == 1) {
          currentStageTitle = S.of(context).uchburchakPiramidasiIkkinchiBosqich;
          currentStageSubtitle = S.of(context).uchburchakPiramidasiIkkinchiBosqichDes;
          currentStageColor = red;
          currentStageTitleColor = lightRed;
          currentCastle = S.of(context).uchburchakQasri;
        } else if (initialCastleIndex == 2) {
          currentStageTitle = S.of(context).doiraQasriUchinchiBosqich;
          currentStageSubtitle = S.of(context).doiraQasriUchinchiBosqichDes;
          currentStageColor = grey;
          currentStageTitleColor = Colors.white;
          currentCastle = S.of(context).doiraQasri;
        } else {
          currentStageTitle = '';
          currentStageSubtitle = '';
          currentCastle = '';
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isStageUpdated) {
      _isStageUpdated = true;
    }

    if (GameState.hearts == 0) {
      _checkHeartRegeneration();
    }
  }

  // ✅ RESET LIGHTNING IF NO INCREASE IN 1 DAY
  void _checkLightningTimeout() async {
    final last = GameState.lastLightningDate;
    if (last != null) {
      final now = DateTime.now();
      final diff = now.difference(last);

      if (diff.inDays >= 2) {
        setState(() {
          if (GameState.activeFreezes > 0) {
            // Use 1 freeze and refresh protection date
            GameState.activeFreezes -= 1;
            GameState.lastLightningDate = now;
          } else {
            // No freeze → reset lightnings
            GameState.lightnings = 0;
            GameState.lastLightningDate = null;
          }
        });

        // Save this change to Firestore
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await GameState.saveState(userId);
        }
      }
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
    } else if (GameState.currentXP2 < GameState.maxXP2) {
      int index = (GameState.currentXP2 / (GameState.maxXP2 / 10)).floor();
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
    // Determine which castle should be shown
    int initialCastleIndex = 0;
    if (GameState.currentXP >= GameState.maxXP && GameState.currentXP2 < GameState.maxXP2) {
      initialCastleIndex = 1;
    } else if (GameState.currentXP2 >= GameState.maxXP2 && GameState.currentXP3 < GameState.maxXP3) {
      initialCastleIndex = 2;
    } else if (GameState.currentXP3 >= GameState.maxXP3 && GameState.currentXP4 < GameState.maxXP4) {
      initialCastleIndex = 3;
    }

    // Castle theme colors
    final castleColors = [
      primaryColor,     // Kvadrat Qasri
      red,      // Uchburchak Piramidasi
      grey,     // Doira Qasri
      grey,     // Future castle
    ];

    // ✅ Set title/subtitle immediately for the initial page
    if (currentStageTitle.isEmpty) {
      if (initialCastleIndex == 0) {
        currentStageTitle = S.of(context).kvadratQasriBirinchiBosqich;
        currentStageSubtitle = S.of(context).kvadratQasriBirinchiBosqichDes;
        currentStageColor = blue;
        currentStageTitleColor = lightBlue;
        currentCastle = S.of(context).squareCastle;
      } else if (initialCastleIndex == 1) {
        currentStageTitle = S.of(context).uchburchakPiramidasiIkkinchiBosqich;
        currentStageSubtitle = S.of(context).uchburchakPiramidasiIkkinchiBosqichDes;
        currentStageColor = red;
        currentStageTitleColor = lightRed;
        currentCastle = S.of(context).uchburchakQasri;
      } else if (initialCastleIndex == 2) {
        currentStageTitle = S.of(context).doiraQasriUchinchiBosqich;
        currentStageSubtitle = S.of(context).doiraQasriUchinchiBosqichDes;
        currentStageColor = grey;
        currentStageTitleColor = Colors.white;
        currentCastle = S.of(context).doiraQasri;
      } else {
        currentStageTitle = '';
        currentStageSubtitle = '';
        currentCastle = '';
      }
    }

    final PageController controller = PageController(
      viewportFraction: 0.85,
      initialPage: initialCastleIndex, // Start from correct castle
    );
    double currentPage = initialCastleIndex.toDouble();

    return StatefulBuilder(
      builder: (context, setStateSB) {
        controller.addListener(() {
          setStateSB(() {
            currentPage = controller.page ?? initialCastleIndex.toDouble();
          });
        });

        final castles = [
          KvadratQasri(
            key: ValueKey(GameState.currentXP),
            onComplete: () {},
          ),
          UchburchakPiramidasi(
            key: ValueKey(GameState.currentXP2),
            onComplete: () {},
          ),
          const Center(child: Text("Yangi qasrlar tez orada qo'shiladi.")),
          const Center(child: Text("Yangi qasrlar tez orada qo'shiladi.")),
        ];

        final isUnlocked = [
          true,
          GameState.currentXP >= GameState.maxXP,
          GameState.currentXP2 >= GameState.maxXP2,
          GameState.currentXP3 >= GameState.maxXP3,
        ];

        double screenHeight = MediaQuery.of(context).size.height;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight * 0.43,
              child: PageView.builder(
                controller: controller,
                itemCount: castles.length,
                onPageChanged: (index) {
                  setState(() {
                    currentCastleIndex = index; // ✅ Track selected castle
                    if (index == 0) {
                      currentStageTitle = S.of(context).kvadratQasriBirinchiBosqich;
                      currentStageSubtitle = S.of(context).kvadratQasriBirinchiBosqichDes;
                      currentStageColor = blue;
                      currentStageTitleColor = lightBlue;
                      currentCastle = S.of(context).squareCastle;
                    } else if (index == 1) {
                      currentStageTitle = S.of(context).uchburchakPiramidasiIkkinchiBosqich;
                      currentStageSubtitle = S.of(context).uchburchakPiramidasiIkkinchiBosqichDes;
                      currentStageColor = red;
                      currentStageTitleColor = lightRed;
                      currentCastle = S.of(context).uchburchakQasri;
                    } else if (index == 2) {
                      currentStageTitle = S.of(context).doiraQasriUchinchiBosqich;
                      currentStageSubtitle = S.of(context).doiraQasriUchinchiBosqichDes;
                      currentStageColor = grey;
                      currentStageTitleColor = Colors.white;
                      currentCastle = S.of(context).doiraQasri;
                    } else {
                      currentStageTitle = '';
                      currentStageSubtitle = '';
                      currentCastle = '';
                    }
                  });
                },
                itemBuilder: (context, index) {
                  double scale = (1 - ((currentPage - index).abs() * 0.2)).clamp(0.8, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: Stack(
                      children: [
                        castles[index],
                        if (!isUnlocked[index])
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.lock, size: 60, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(castles.length, (index) {
                bool isActive = index == currentPage.round();
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 12 : 8,
                  height: isActive ? 12 : 8,
                  decoration: BoxDecoration(
                    color: isActive ? castleColors[index] : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _getCurrentLightining() {
    return _iconWithValue(
      GameState.lightnings == 0
          ? 'assets/icons/Lightining1.png'
          : 'assets/icons/Lightining.png',
      '${GameState.lightnings}',
      GameState.lightnings == 0 ? grey : primaryPurple,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconWithValue('assets/icons/Heart.png', '${GameState.hearts}', red),
            _iconWithValue('assets/icons/Diamond.png', '${GameState.gems}', green),
            _getCurrentLightining(),
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
                        border: Border.all(width: 2, color: Colors.white),
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
                    AnimatedButton(
                      borderRadius: 20,
                      height: screenHeight * 0.10,
                      width: screenWidth * 0.90,
                      color: currentStageColor,
                      onPressed: () async {
                        final hasConnection = context.read<ConnectivityService>().hasConnection;
                        bool? result;

                        if (!hasConnection) {
                          // Navigate to NoInternetPage if no connection
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NoInternetPage()),
                          );
                          return; // stop further navigation
                        } else {
                          result = await Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 600),
                              pageBuilder: (_, __, ___) {
                                if (currentCastleIndex == 0) {
                                  return const LevelPage(); // Kvadrat Qasri
                                } else if (currentCastleIndex == 1) {
                                  return const LevelPage2(); // Uchburchak Piramidasi
                                } else if (currentCastleIndex == 2) {
                                  return const LevelPage3(); // Doira Qasri
                                } else {
                                  return const LevelPage(); // Fallback
                                }
                              },
                              transitionsBuilder: (_, animation, __, child) => SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                )),
                                child: child,
                              ),
                            ),
                          );
                        }

                        if (result == true) {
                          setState(() {
                            // Optionally refresh anything
                          });
                        }
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentStageTitle,
                                style: TextStyle(fontSize: 15, color: currentStageTitleColor, fontFamily: Font, height: 1.2)),
                            Text(currentStageSubtitle,
                                style: const TextStyle(fontSize: 22, color: Colors.white, fontFamily: Font, height: 1)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(color: greyColor, thickness: 2, endIndent: 10),
                          ),
                          Text(
                            currentCastle,
                            style: const TextStyle(fontSize: 21, fontFamily: Font, color: grey),
                          ),
                          const Expanded(
                            child: Divider(color: greyColor, thickness: 2, indent: 20),
                          ),
                        ],
                      ),
                    ),
                    _getCurrentCastleWidget(),
                    if (GameState.hearts == 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/Heart.png', width: 28, height: 28),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).rechargingIn(_formatTime(secondsLeft)),
                            style: const TextStyle(fontSize: 16, color: red, fontFamily: Font),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AbsorbPointer(
                absorbing: GameState.hearts == 0,
                child: AnimatedButton(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: GameState.hearts > 0 ? orange : greyColor,
                  borderRadius: 16,
                  onPressed: () async {
                    final hasConnection = context.read<ConnectivityService>().hasConnection;

                    if (!hasConnection) {
                      // Navigate to NoInternetPage if no connection
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NoInternetPage()),
                      );
                      return; // stop further navigation
                    }

                    // Navigate to your main page if connected
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => _getCurrentMainPage()),
                    );

                    if (!mounted) return;

                    setState(() {
                      // any state updates here after returning
                    });
                  },
                  child: Text(
                    S.of(context).start,
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: Font),
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
            fontFamily: BoldFont,
            color: color,
          ),
        ),
      ],
    );
  }
}
