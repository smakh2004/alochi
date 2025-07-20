import 'package:alochi_math_app/components/color.dart';
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
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400, // total area height
                width: double.infinity,
                child: Stack(
                  children: [
                    // BACKGROUND: two colors
                    Column(
                      children: [
                        Container(height: 338, color: alochiInfitity),
                      ],
                    ),

                    // FOREGROUND: animation
                    Center(
                      child: SizedBox(
                        height: 400, // animation size
                        child: Lottie.asset(
                          'assets/animations/MrSquareAlochiInfinity.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Replaces your current Padding around the features
              Center(
                child: SizedBox(
                  width: 300, 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icons/HeartInfinity.png', height: 40, width: 40),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).cheksizJonlar,
                            style: TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.asset('assets/icons/StormInfinity.png', height: 40, width: 40),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              S.of(context).mathShtorm,
                              style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold
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


              // Option 1
              _buildSelectButton(
                index: 0,
                icon: Icons.star,
                text: S.of(context).onePremium,
                cost: '\$ 3'
              ),

              // Option 2
              _buildSelectButton(
                index: 1,
                icon: Icons.bolt,
                text: S.of(context).threePremium,
                cost: '\$ 8'
              ),

              // Option 3
              _buildSelectButton(
                index: 2,
                icon: Icons.diamond,
                text: S.of(context).twelvePremium,
                cost: '\$ 20'
              ),

              const SizedBox(height: 20),

              // YOQISH Animated Button
              AnimatedButton(
                height: 50,
                width: 300,
                color: _selectedIndex != null ? primaryColor : greyColor,
                enabled: true, // Always enabled, logic handled inside
                onPressed: () {
                  if (_selectedIndex == null) return;

                  print("Activated with selection: $_selectedIndex");
                  // TODO: Add activation logic
                },
                child: Center(
                  child: Text(
                    S.of(context).yoqish,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

  Widget _buildSelectButton({
    required int index,
    required IconData icon,
    required String text,
    required String cost
  }) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = isSelected ? null : index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 110,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primaryColor : greyColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Centered Icon and Text
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? primaryColor : greyColor,
                    size: 40,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryColor : greyColor,
                    ),
                  ),
                ],
              ),
            ),

            // Top-right icon fully inside corner
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : greyColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cost,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.white,
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
