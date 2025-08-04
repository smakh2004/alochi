import 'dart:math';

import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/main.dart';
import 'package:alochi_math_app/pages/Folower.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/SettingsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  User? user;
  bool isUzbek = true;

  double progress = 0.0;
  int percentage = 0;
  int score = 0;

  bool isRotated = false; // Track rotation state settings icon
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _updateProgress();
    // Rotation for settings icon
     _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    isUzbek = locale.languageCode == 'uz';
  }

  void _updateProgress() {
    setState(() {
      progress = GameState.currentXP / GameState.maxXP;
      percentage = (progress * 100).toInt();
      score = GameState.score + GameState.scoreDop;
    });
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    final date = dateTime.toLocal();
    return '${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    final months = [
      '',
      S.of(context).yanvar,
      S.of(context).fevral,
      S.of(context).mart,
      S.of(context).aprel,
      S.of(context).may,
      S.of(context).iyun,
      S.of(context).iyul,
      S.of(context).avgust,
      S.of(context).sentabr,
      S.of(context).oktabr,
      S.of(context).noyabr,
      S.of(context).dekabr,
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Header Section
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: primaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/animations/MrSquareProfile.json',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                S.of(context).birinchiBosqich,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: Font,
                                ),
                              ),
                              Text(
                                S.of(context).kvadratQasri,
                                style: TextStyle(
                                  fontFamily: BoldFont,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),

                              /// Language Switch
                              GestureDetector(
                                onTap: () {
                                  final newLocale = isUzbek
                                      ? const Locale('en')
                                      : const Locale('uz');
                                  MyApp.setLocale(context, newLocale);
                                  setState(() {
                                    isUzbek = !isUzbek;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(left: 12),
                                                child: Text(
                                                  'UZ',
                                                  style: TextStyle(
                                                    color: grey,
                                                    fontFamily: Font,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 12),
                                                child: Text(
                                                  'EN',
                                                  style: TextStyle(
                                                    color: grey,
                                                    fontFamily: Font,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          AnimatedAlign(
                                            alignment: isUzbek
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: isUzbek ? primaryColor : red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  isUzbek ? 'UZ' : 'EN',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: Font,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      S.of(context).langauage,
                                      style: const TextStyle(
                                        fontFamily: Font,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Settings Icon (top right)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        if (!isRotated) {
                          _controller.forward(); // Rotate icon forward
                        } else {
                          _controller.reverse(); // Rotate icon back
                        }
                        setState(() {
                          isRotated = !isRotated;
                        });
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 600),
                            pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                              return SlideTransition(
                                position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
                                child: child,
                              );
                            },
                          ),
                        ).then((_) {
                          // Reset rotation when returning to this page
                          _controller.reverse();
                          setState(() {
                            isRotated = false;
                          });
                        });
                      },
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.25).animate(_controller),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// User Info
              Text(
                user != null
                    ? '${GameState.firstName} ${GameState.lastName}'.trim().isEmpty
                        ? S.of(context).foydalanuvchi
                        : '${GameState.firstName} ${GameState.lastName}'
                    : S.of(context).mehmon,
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: Font,
                  color: questionColor,
                ),
              ),

              user != null
                  ? Text(
                      '${user!.email} | ${S.of(context).registratsiya}: ${_formatDate(user!.metadata.creationTime)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: darkGrey, fontFamily: Font,),
                    )
                  : Column(
                      children: [
                        Text(
                          S.of(context).sizHaliKirmagansiz,
                          style: const TextStyle(
                              fontSize: 14,
                              color: red,
                              fontFamily: Font,),
                        ),
                        const SizedBox(height: 12),
                        AnimatedButton(
                          width: 200,
                          height: 50,
                          color: primaryColor,
                          borderRadius: 18,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckPage()),
                            );
                          },
                          child: Center(
                            child: Text(
                              S.of(context).akkauntgaKirish,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: Font,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 10),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) => FollowPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                        return SlideTransition(
                          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  height: 65,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                fontFamily: Font,
                                color: questionColor,
                                fontSize: 30
                              ),
                            ),
                            Text(
                              S.of(context).following, // FOLLOWING
                              style: TextStyle(
                                fontFamily: Font,
                                color: darkGrey,
                                fontSize: 14
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 2,
                          height: 60,
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              '10',
                              style: TextStyle(
                                fontFamily: Font,
                                color: questionColor,
                                fontSize: 30
                              ),
                            ),
                            Text(
                              S.of(context).followers, // Followers
                              style: TextStyle(
                                fontFamily: Font,
                                color: darkGrey,
                                fontSize: 14
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Profile Buttons
              if (user != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        width: 260,
                        height: 50,
                        color: Colors.white,
                        borderRadius: 18,
                        onPressed: () {
                          // Navigation here
                          //////////////////
                          ///////////////////////////////////////////////////////////
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add, color: primaryColor),
                              SizedBox(width: 5),
                              Text(
                                S.of(context).addFriends, // ADD FRIENDS
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontFamily: Font,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      AnimatedButton(
                        height: 50,
                        width: 50,
                        borderRadius: 14,
                        color: Colors.white,
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor, width: 2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.share, color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              /// Progress Bar Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: greyColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Section: Title + Progress
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Left Text Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).statistika, // Statistika
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: questionColor,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                S.of(context).BirinchiBosqich, // 1 LEVEL
                                style: TextStyle(
                                  fontFamily: Font,
                                  fontSize: 16,
                                  color: darkGrey,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                S.of(context).KvadratQasri, // Square Castle
                                style: TextStyle(
                                  fontFamily: Font,
                                  fontSize: 20,
                                  color: questionColor,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Progress Arc
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: halfCircularProgress(
                            percentage: percentage.toDouble(),
                            color: questionColor,
                            label: 'PROGRESS',
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Divider(color: greyColor, thickness: 2),
                    const SizedBox(height: 16),

                    /// Top 2 Stats
                    Row(
                      children: [
                        /// Math Storm
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).mathStormP, // MATH STORM
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Image.asset('assets/icons/ArifmeticStorm.png', width: 30, height: 30),
                                  SizedBox(width: 4),
                                  Text(
                                    GameState.matematikShtorm.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        /// Arifmetika
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).arifmetikaP, // ARIFMETIKA
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    GameState.arifmetika.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Middle 2 Stats
                    Row(
                      children: [
                        /// Math Storm
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).multiplikativ, // Multiplikativ
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    GameState.kopaytirish.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        /// Arifmetika
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).logika, // Logika
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    GameState.logika.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Divider(color: greyColor, thickness: 2),
                    const SizedBox(height: 16),

                    /// Final Row: Lightning + Points
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).glabaliSeriya, // G'alabali seriya
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  GameState.lightnings > 0
                                      ? Image.asset('assets/icons/1.png', width: 30, height: 30)
                                      : Image.asset('assets/icons/Lightining1.png', width: 30, height: 30),
                                  Text(
                                    GameState.lightnings.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).umumiyOchko, // Umumiy ochko
                                style: TextStyle(
                                  fontFamily: Font,
                                  color: darkGrey,
                                  fontSize: 14,
                                  height: 0.2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Image.asset('assets/icons/2.png', width: 30, height: 30),
                                  Text(
                                    GameState.score.toString(),
                                    style: TextStyle(
                                      fontFamily: Font,
                                      color: questionColor,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Victory Streak & Score Cards

              // /// Yutuqlar
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         S.of(context).yutuqlar,
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontFamily: Font,
              //           color: questionColor
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             PageRouteBuilder(
              //               transitionDuration: const Duration(milliseconds: 600),
              //               pageBuilder: (context, animation, secondaryAnimation) => const AchievementsPage(),
              //               transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //                 final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              //                 return SlideTransition(
              //                   position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
              //                   child: child,
              //                 );
              //               },
              //             ),
              //           );
              //         },
              //         child: Text(
              //           S.of(context).hammasiniKorish,
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: primaryColor,
              //             fontFamily: Font,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // /// Common container with scrollable row of images inside
              // Container(
              //   height: 180,
              //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: greyColor, width: 2),
              //     borderRadius: BorderRadius.circular(18),
              //     color: Colors.white,
              //   ),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         Image.asset(
              //           'assets/medals/MrSquareMedal.png',
              //           width: 140,
              //           height: 140,
              //         ),
              //         Container(
              //           width: 2,
              //           height: 180,
              //           color: greyColor, // or any other color
              //         ),
              //         Image.asset(
              //           'assets/medals/MrTriangleLightining.png',
              //           width: 140,
              //           height: 140,
              //         ),
              //         Container(
              //           width: 2,
              //           height: 180,
              //           color: greyColor, // or any other color
              //         ),
              //         Image.asset(
              //           'assets/medals/MrCircleTimer.png',
              //           width: 140,
              //           height: 140,
              //         ),
              //         // Add more individually styled images here
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget halfCircularProgress({
  required double percentage,
  required Color color,
  required String label,
}) {
  return SizedBox(
    width: 100,
    height: 80, 
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 100,
          height: 60,
          child: CustomPaint(
            painter: _HalfCirclePainter(
              percentage: percentage,
              color: primaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            '${percentage.toInt()}',
            style: TextStyle(
              fontSize: 40,
              color: questionColor,
              fontFamily: Font
            ),
          ),
        ),
      ],
    ),
  );
}

class _HalfCirclePainter extends CustomPainter {
  final double percentage;
  final Color color;

  _HalfCirclePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height;
    final radius = size.width / 2;

    final rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    final backgroundPaint = Paint()
      ..color = greyColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final startAngle = 5 * pi / 6; // 150 degrees
    final sweepAngle = 4 * pi / 3; // 240 degrees

    // Draw background arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(rect, startAngle, sweepAngle * (percentage / 100), false, progressPaint);

    // Draw 0 and 100 labels
    final textPainter0 = TextPainter(
      text: TextSpan(
        text: '0',
        style: TextStyle(fontSize: 12, color: darkGrey, fontFamily: Font),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textPainter100 = TextPainter(
      text: TextSpan(
        text: '100',
        style: TextStyle(fontSize: 12, color: darkGrey, fontFamily: Font),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Positions for 0° and 240° labels
    final angle0 = startAngle;
    final angle100 = startAngle + sweepAngle;

    final offset0 = Offset(
      centerX + radius * cos(angle0) - textPainter0.width / 2,
      centerY + radius * sin(angle0) - textPainter0.height / 2 + 12, // shift down
    );

    final offset100 = Offset(
      centerX + radius * cos(angle100) - textPainter100.width / 2,
      centerY + radius * sin(angle100) - textPainter100.height / 2 + 12, // shift down
    );

    textPainter0.paint(canvas, offset0);
    textPainter100.paint(canvas, offset100);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}