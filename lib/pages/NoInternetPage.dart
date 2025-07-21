import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/SplashScreenPage.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: noInternet,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie animation
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  'assets/animations/MrSquareNoInternet.json',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                S.of(context).noConnection,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AnimatedButton(
                height: 50,
                width: 200,
                color: Colors.white,
                enabled: true,
                borderRadius: 18,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashScreenPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).qaytaUrinish,
                    style: TextStyle(
                      color: questionColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
