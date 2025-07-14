import 'package:alochi_math_app/auth/auth_page.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/BoshlangichSinf.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/Student/Student.dart';
import 'package:alochi_math_app/pages/YuqoriSinf/YuqoriSinf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  Future<Widget> _getNextPage(User user) async {
    await GameState.loadState(user.uid); // ✅ Load from Firestore

    // ✅ Then return the correct page
    if ((GameState.selectedLevel == 'Boshlang\'ich sinf') || (GameState.selectedLevel == 'Elementary school')) {
      return const BoshlangichSinf();
    } else if ((GameState.selectedLevel == 'Yuqori sinf') || (GameState.selectedLevel == 'High school')) {
      return const YuqoriSinf();
    } else if ((GameState.selectedLevel == 'Student')) {
      return const Student();
    } else {
      return const BoshlangichSinf(); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data != null) {
            // ✅ User is logged in, load Firestore state before navigating
            return FutureBuilder<Widget>(
              future: _getNextPage(snapshot.data!),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (futureSnapshot.hasData) {
                  return futureSnapshot.data!;
                } else {
                  return const Center(child: Text("Something went wrong..."));
                }
              },
            );
          } else {
            // ❌ Not logged in — go to auth page
            return const AuthPage();
          }
        },
      ),
    );
  }
}
