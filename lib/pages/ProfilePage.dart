import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/main.dart';
import 'package:alochi_math_app/pages/AchievementsPage.dart';
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

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool isUzbek = true;

  double progress = 0.0;
  int percentage = 0;
  double progress2 = 0.0;
  int percentage2 = 0;
  double progress3 = 0.0;
  int percentage3 = 0;
  double progress4 = 0.0;
  int percentage4 = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _updateProgress();
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

      progress2 = GameState.arifmetika / GameState.arifmetikaMax;
      percentage2 = (progress2 * 100).toInt();

      progress3 = GameState.logika / GameState.logikaMax;
      percentage3 = (progress3 * 100).toInt();

      progress4 = GameState.kopaytirish / GameState.kopaytirishMax;
      percentage4 = (progress4 * 100).toInt();

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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: primaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 12),
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
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            S.of(context).kvadratQasri,
                            style: TextStyle(
                              fontFamily: primaryFont,
                              fontWeight: FontWeight.bold,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Text(
                                              'UZ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 12),
                                            child: Text(
                                              'EN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      AnimatedAlign(
                                        alignment: isUzbek
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: isUzbek
                                                ? primaryColor
                                                : red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              isUzbek ? 'UZ' : 'EN',
                                              style: const TextStyle(
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
                                const SizedBox(height: 5),
                                Text(
                                  S.of(context).langauage,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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

              const SizedBox(height: 15),

              /// User Info
              Text(
                user != null
                    ? '${GameState.firstName} ${GameState.lastName}'.trim().isEmpty
                        ? S.of(context).foydalanuvchi
                        : '${GameState.firstName} ${GameState.lastName}'
                    : S.of(context).mehmon,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              user != null
                  ? Text(
                      '${user!.email} | ${S.of(context).registratsiya}: ${_formatDate(user!.metadata.creationTime)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: darkGrey),
                    )
                  : Column(
                      children: [
                        Text(
                          S.of(context).sizHaliKirmagansiz,
                          style: const TextStyle(
                              fontSize: 14,
                              color: red,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        AnimatedButton(
                          width: 200,
                          height: 50,
                          color: primaryColor,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 20),

              /// Profile Buttons
              if (user != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        width: 200,
                        height: 50,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).meningProfilim,
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      AnimatedButton(
                        height: 50,
                        width: 50,
                        color: Colors.white,
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.share, color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              /// Statistika Title
              Text(
                S.of(context).statistika,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// Matematik shtorm
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: grey, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/ArifmeticStorm.png',
                            width: 44,
                            height: 44,
                          ),
                          SizedBox(width: 8),
                          Column(
                            children: [
                              SizedBox(height: 12),
                              Text(
                                GameState.matematikShtorm.toString(),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S.of(context).matematikShtorm,
                        style: TextStyle(
                          fontSize: 15,
                          color: darkGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              /// Progress Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: grey, width: 2),
                ),
                child: Column(
                  children: [
                    // 1st Row: Progress & Arifmetika
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Progress Circle
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 8,
                                  backgroundColor: greyColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$percentage%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Progress Text
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              S.of(context).progress,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Arifmetika Circle
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress2,
                                  strokeWidth: 8,
                                  backgroundColor: greyColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(orange),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$percentage2%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Arifmetika Text
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              S.of(context).arifmetika,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 2nd Row: Ko'paytirish & Logika
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ko'paytirish Circle
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress4,
                                  strokeWidth: 8,
                                  backgroundColor: greyColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(red),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$percentage4%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Ko'paytirish Text
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              S.of(context).multiplikativ,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Logika Circle
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress3,
                                  strokeWidth: 8,
                                  backgroundColor: greyColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(green),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '$percentage3%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Logika Text
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              S.of(context).logika,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// Victory Streak & Score Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    /// Streak Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: grey, width: 2),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/Lightining.png',
                              width: 44,
                              height: 44,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    GameState.lightnings.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).glabaliSeriya,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    /// XP Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: grey, width: 2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.bolt, color: orange, size: 44),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    GameState.score.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).umumiyOchko,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Yutuqlar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).yutuqlar,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 600),
                            pageBuilder: (context, animation, secondaryAnimation) => const AchievementsPage(),
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
                      child: Text(
                        S.of(context).hammasiniKorish,
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Common container with scrollable row of images inside
              Container(
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: greyColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/medals/MrSquareMedal.png',
                        width: 140,
                        height: 140,
                      ),
                      Container(
                        width: 2,
                        height: 180,
                        color: greyColor, // or any other color
                      ),
                      Image.asset(
                        'assets/medals/MrTriangleLightining.png',
                        width: 140,
                        height: 140,
                      ),
                      Container(
                        width: 2,
                        height: 180,
                        color: greyColor, // or any other color
                      ),
                      Image.asset(
                        'assets/medals/MrCircleTimer.png',
                        width: 140,
                        height: 140,
                      ),
                      // Add more individually styled images here
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}