// ignore_for_file: deprecated_member_use

import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            Text(S.of(context).settingsNew, style: TextStyle(fontFamily: primaryFont, color: darkGrey)),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Akkaunt',
                style: TextStyle(
                  fontSize: 20,
                  color: darkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Parameters',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(height: 2, color: greyColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(height: 2, color: greyColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(height: 2, color: greyColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Courses',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Support',
                style: TextStyle(
                  fontSize: 20,
                  color: darkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Help center',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(height: 2, color: greyColor),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      launch('https://forms.gle/t462gyfwawrQqS1v8');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Send feedback',
                            style: TextStyle(
                              fontSize: 20,
                              color: questionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: darkGrey,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            AnimatedButton(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.85,
              color: Colors.white,
              borderRadius: 14,
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
            
                  // 🧠 Clear all in-memory game state after logout
                  GameState.reset();
            
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed out successfully')),
                  );
            
                  // Navigate to Welcome/Login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CheckPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign out failed: ${e.toString()}')),
                  );
                }
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
                    Text(
                      S.of(context).signOut,
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
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
