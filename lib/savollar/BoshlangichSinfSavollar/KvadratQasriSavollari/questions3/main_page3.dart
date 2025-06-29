import 'package:alochi_math_app/components/color.dart';
import 'package:flutter/material.dart';

class MainPage3 extends StatefulWidget {
  const MainPage3({super.key});

  @override
  State<MainPage3> createState() => _MainPage3State();
}

class _MainPage3State extends State<MainPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(child: Text('Ishlanmoqda',style: TextStyle(fontSize: 20),)),
    );
  }
}