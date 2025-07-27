// ignore_for_file: use_build_context_synchronously

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedLevel;

  Future<void> signUp() async {
    if (!passwordConfirmed()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).parolNotogriMsg)),
      );
      return;
    }

    if (_selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).darajaTanlanmadiMsg)),
      );
      return;
    }

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).ismFamiliyaYoqMsg)),
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final userId = userCredential.user?.uid;

      if (userId != null) {
        GameState.selectedLevel = _selectedLevel!;
        GameState.firstName = firstName;
        GameState.lastName = lastName;
        GameState.reset();
        await GameState.saveState(userId);
        await GameState.loadState(userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).royxatdanOtildiMsg)),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'email-already-in-use') {
        message = S.of(context).emailAlreadyExists;
      } else if (e.code == 'invalid-email') {
        message = S.of(context).emailInvalid1;
      } else if (e.code == 'weak-password') {
        message = S.of(context).weakPassword1;
      } else {
        message = '${S.of(context).errorOccurred} ${e.code}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).xatolik} ${e.toString()}')),
      );
    }
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
                  style: const TextStyle(fontSize: 24, fontFamily: Font,),
                ),
                Text(
                  S.of(context).matematikaDunyosi,
                  style: const TextStyle(fontSize: 18, fontFamily: Font,),
                ),
                const SizedBox(height: 10),

                // First Name
                _buildTextField(_firstNameController, Icons.person, S.of(context).firstName),
                const SizedBox(height: 10),

                // Last Name
                _buildTextField(_lastNameController, Icons.person_outline, S.of(context).lastName),
                const SizedBox(height: 10),

                // Email Field
                _buildTextField(_emailController, Icons.email, S.of(context).email),
                const SizedBox(height: 10),
                
                // Level Selection Dropdown with DropdownButton2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 305,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: greyColor, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          value: _selectedLevel,
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Icon(Icons.school, color: questionColor),
                              SizedBox(width: 17),
                              Text(
                                S.of(context).darajaniTanlang,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: questionColor,
                                ),
                              ),
                            ],
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.arrow_drop_down, color: questionColor),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: questionColor,
                          ),
                          // Menu items
                          items: [
                            DropdownMenuItem(
                              value: S.of(context).boshlangich,
                              child: Text(
                                S.of(context).boshlangich,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: questionColor,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: S.of(context).yuqoriSinf,
                              child: Text(
                                S.of(context).yuqoriSinf,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: questionColor,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: S.of(context).student,
                              child: Text(
                                S.of(context).student,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: questionColor,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedLevel = value;
                              GameState.selectedLevel = value!;
                            });
                          },
                          // Dropdown menu style
                          dropdownStyleData: DropdownStyleData(
                            elevation: 0, // remove shadow
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: greyColor, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // Make the menu match the button width
                            width: 305,
                            offset: const Offset(-12, -12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
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
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: Font,),
                  ),
                ),
                const SizedBox(height: 10),

                // Switch to login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).akkauntizBormi,
                        style: const TextStyle(fontFamily: Font, fontSize: 16)),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        S.of(context).tizimgaKirishQ,
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: Font,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  S.of(context).googleOrqali,
                  style: const TextStyle(fontSize: 16, fontFamily: Font, color: Colors.grey),
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
