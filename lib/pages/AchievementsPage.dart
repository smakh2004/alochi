import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:animated_button/animated_button.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  void _showMedalDetails(String imagePath, String medalName, String medalDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent, 
          contentPadding: EdgeInsets.zero, 
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: grey, 
                width: 2,            
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  medalName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 1),
                Image.asset(imagePath, width: 220, height: 220),
                const SizedBox(height: 1),
                Text(
                  medalDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGrey),
                ),
                const SizedBox(height: 20),
                AnimatedButton(
                  width: 150,
                  height: 50,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedal(String imagePath, String name, String description) {
    return GestureDetector(
      onTap: () => _showMedalDetails(imagePath, name, description),
      child: Image.asset(imagePath, width: 100, height: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              S.of(context).yutuqlar,
              style: TextStyle(color: darkGrey, fontFamily: primaryFont, fontSize: 18),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back, color: darkGrey),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).TwoFiveYutuqlar, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildMedal(
                      'assets/medals/MrSquareMedal.png',
                      S.of(context).kvadratQasriKubogi,
                      S.of(context).kvadratQasriKubogiDes,
                    ),
                    _buildMedal(
                      'assets/medals/MrTriangleLightining.png',
                      S.of(context).galabaliSeriyaBoshlandi,
                      S.of(context).galabaliSeriyaBoshlandiDes,
                    ),
                    _buildMedal(
                      'assets/medals/MrCircleTimer.png',
                      S.of(context).tezkor,
                      S.of(context).tezkorDes,
                    ),
                    _buildMedal(
                      'assets/medals/LockMedal.png',
                      S.of(context).yopiqMedal,
                      S.of(context).yopiqMedalDes,
                    ),
                    _buildMedal(
                      'assets/medals/LockMedal.png',
                      S.of(context).yopiqMedal,
                      S.of(context).yopiqMedalDes,
                    ),
                    _buildMedal(
                      'assets/medals/LockMedal.png',
                      S.of(context).yopiqMedal,
                      S.of(context).yopiqMedalDes,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
          
                Text(S.of(context).TwoSixYutuqlar, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(6, (index) {
                    return _buildMedal(
                      'assets/medals/LockMedal.png',
                      S.of(context).yopiqMedal,
                      S.of(context).yopiqMedalDes,
                    );
                  }),
                ),
                const SizedBox(height: 20),
          
                Text(S.of(context).TwoSevenYutuqlar, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(6, (index) {
                    return _buildMedal(
                      'assets/medals/LockMedal.png',
                      S.of(context).yopiqMedal,
                      S.of(context).yopiqMedalDes,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
