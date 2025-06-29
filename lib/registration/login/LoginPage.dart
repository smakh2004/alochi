import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_button/animated_button.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim(),
      );

      // Optional: Navigate to HomePage after successful sign-in
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = S.of(context).emailNotFound; 
      } else if (e.code == 'wrong-password') {
        errorMessage = S.of(context).wrongPassword;
      } else {
        errorMessage = S.of(context).somethingWentWrong;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animation
                Lottie.asset(
                  'assets/animations/MrSquareSalom.json',
                  width: 240,
                  height: 240,
                ),
                
                SizedBox(height: 10),
                // Text 
                Text(
                  S.of(context).tizimgaKirish,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
        
                // Text Xursandmiz 
                Text(
                  S.of(context).tizimgaKirishDes,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
        
                SizedBox(height: 10),
                // Email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: greyColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: 290,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                            hintText: S.of(context).email,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 10),
                // Password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: greyColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: 290,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.lock),
                            hintText: S.of(context).parol,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 10),
                // login button
                AnimatedButton(
                  height: 50,
                  width: 310,
                  color: primaryColor,
                  onPressed: () async {
                    signIn();
                  },
                  child: Text(
                    S.of(context).kirish,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        
                SizedBox(height: 10),
                //not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).akkauntizYoqmi,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        S.of(context).registratsiyaQilish, 
                        style: TextStyle(
                          color: primaryColor, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 10),
                // Text 
                Text(
                  S.of(context).googleOrqali,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 10),
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
}