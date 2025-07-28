import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top animation area
                    SizedBox(
                      height: 400, // total area height
                      width: double.infinity,
                      child: Stack(
                        children: [
                          // BACKGROUND: two colors
                          Column(
                            children: [
                              Container(height: 400, color: alochiInfitity),
                            ],
                          ),

                          // FOREGROUND: animation
                          Center(
                            child: SizedBox(
                              height: 400, 
                              child: Lottie.asset(
                                'assets/animations/MrSquareAlochiInfinity.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Features
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/HeartInfinity.png', height: 60, width: 60),
                                const SizedBox(width: 10),
                                Text(
                                  S.of(context).cheksizJonlar,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: primaryColor,
                                    fontFamily: Font,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/icons/StormInfinity.png', height: 60, width: 60),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    S.of(context).mathShtorm,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: primaryColor,
                                      fontFamily: Font,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // 👉 add more scrollable content here if needed
                  ],
                ),
              ),
            ),

            // ✅ Buttons pinned to bottom
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    height: 1,          
                    thickness: 2,       
                    color: greyColor, 
                  ),
                  SizedBox(height: 20),
                  AnimatedButton(
                    height: 50,
                    width: 300,
                    borderRadius: 18,
                    color: primaryColor,
                    onPressed: () {
                      // your action here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GET STARTED FOR',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: Font,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '3.00\$',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: Font,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'NO, THANKS',
                      style: const TextStyle(
                        color: primaryColor,
                        fontFamily: Font,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
