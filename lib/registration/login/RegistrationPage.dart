import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistrationPage({super.key, required this.showLoginPage});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // You can navigate or show a success message here if needed
      } on FirebaseAuthException catch (e) {
        String errorMessage;

        if (e.code == 'email-already-in-use') {
          errorMessage = S.of(context).emailAlreadyUsed;
        } else if (e.code == 'invalid-email') {
          errorMessage = S.of(context).emailInvalid;
        } else if (e.code == 'weak-password') {
          errorMessage = S.of(context).weakPassword;
        } else {
          errorMessage = S.of(context).somethingWentWrong;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage)
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Parollar bir xil emas"),
        ),
      );
    }
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/animations/MrSquareSalom.json',
                  width: 240,
                  height: 240,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).registratsiya,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  S.of(context).matematikaDunyosi,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),

                // Email Field
                _buildTextField(_emailController, Icons.email, S.of(context).email),
                const SizedBox(height: 10),

                // Password Field
                _buildTextField(_passwordController, Icons.lock, S.of(context).parol, obscure: true),
                const SizedBox(height: 10),

                // Confirm Password Field
                _buildTextField(_confirmPasswordController, Icons.lock, S.of(context).parolniTasdiqlash, obscure: true),
                const SizedBox(height: 10),

                // Register Button
                AnimatedButton(
                  height: 50,
                  width: 310,
                  color: primaryColor,
                  onPressed: () async {
                    await signUp();
                  },
                  child: Text(
                    S.of(context).registratsiyaQilishQ,
                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // Switch to login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).akkauntizBormi,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        S.of(context).tizimgaKirishQ,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  S.of(context).googleOrqali,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 10),

                // Google login icon
                GestureDetector(
                  onTap: () {
                    // TODO: Implement Google sign-in logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/icons/google.png', height: 24, width: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String hint,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: greyColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 290,
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(icon),
                hintText: hint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
