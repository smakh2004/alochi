import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/main.dart';
import 'package:alochi_math_app/welcome_pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

bool isUzbek = true;

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 200),
                    Text(
                      'A\'lochi',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontFamily: primaryFont,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedButton(
                      height: 50,
                      width: 250,
                      color: primaryColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()),
                        );
                      },
                      child: const Text(
                        'START',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedButton(
                      height: 50,
                      width: 250,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckPage()),
                        );
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
                            S.of(context).akkaunt,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: size.height * 0.3,
                      child: Lottie.asset(
                        'assets/animations/MrSquareStartButton.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Language toggle at top-right
          Positioned(
            top: 16,
            right: 16,
            child: Padding(
              padding: const EdgeInsets.only(top: 28, right: 6),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isUzbek = !isUzbek;
                        MyApp.setLocale(context, Locale(isUzbek ? 'uz' : 'en'));
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Row showing both "UZ" and "EN"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: EdgeInsets.only(right: 12),
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
                          // Animated switcher circle
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(S.of(context).langauage, style: TextStyle(fontWeight: FontWeight.bold, color: greyColor),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
