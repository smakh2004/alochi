import 'package:alochi_math_app/auth/check_page.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:animated_button/animated_button.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Center(
        child: AnimatedButton(
          height: 50,
          width: 200,
          color: primaryColor,
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
          child: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
