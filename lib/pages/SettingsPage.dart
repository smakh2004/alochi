// ignore_for_file: deprecated_member_use

import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(S.of(context).settingsNew,
                style: TextStyle(fontFamily: BoldFont, color: darkGrey)),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    S.of(context).save,
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontFamily: Font,
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
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            // Akkaunt
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).akkauntLow,
                style: TextStyle(
                  fontSize: 22,
                  color: darkGrey,
                  fontFamily: Font,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  // Parameters
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).parameters,
                            style: TextStyle(
                              fontSize: 22,
                              color: questionColor,
                              fontFamily: Font,
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

                  // Profile
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).profile,
                            style: TextStyle(
                              fontSize: 22,
                              color: questionColor,
                              fontFamily: Font,
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

                  // Notifications
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).notifications,
                            style: TextStyle(
                              fontSize: 22,
                              color: questionColor,
                              fontFamily: Font,
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

                  // Courses
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).kurslar,
                            style: TextStyle(
                              fontSize: 22,
                              color: questionColor,
                              fontFamily: Font,
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
            const SizedBox(height: 30),
            
            // Support
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).support,
                style: TextStyle(
                  fontSize: 22,
                  color: darkGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  // Help Center
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).helpCenter,
                            style: TextStyle(
                              fontSize: 22,
                              color: questionColor,
                              fontFamily: Font,
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

                  // Send feedback
                  PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(height: 2, color: greyColor),
                  ),
                  Link(
                    target: LinkTarget.blank,
                    uri: Uri.parse('https://forms.gle/8AmcMnkhvYFtapi88'),
                    builder: (context, followLink) {
                      return InkWell(
                        onTap: followLink,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).sendFeedback,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: questionColor,
                                  fontFamily: Font,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: darkGrey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Sign out
            AnimatedButton(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.85,
              color: Colors.white,
              borderRadius: 14,
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();

                  // Clear all in-memory game state after logout
                  GameState.reset();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Signed out successfully')),
                  );

                  // Navigate to Welcome/Login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckPage()),
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
                        fontSize: 18,
                        color: primaryColor,
                        fontFamily: Font,
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
