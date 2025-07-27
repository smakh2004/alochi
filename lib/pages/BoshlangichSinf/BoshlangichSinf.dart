// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_final_fields
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/MathStorm/MathStorm.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/HomePage.dart';
import 'package:alochi_math_app/pages/LeaderBoard.dart';
import 'package:alochi_math_app/pages/ProfilePage.dart';
import 'package:alochi_math_app/pages/StorePage.dart';
import 'package:flutter/material.dart';

class BoshlangichSinf extends StatefulWidget {
  const BoshlangichSinf({super.key});

  @override
  State<BoshlangichSinf> createState() => _BoshlangichSinfState();
}

class _BoshlangichSinfState extends State<BoshlangichSinf> {
  int _selectedIndex = 0;

  // Create fresh page list
  List<Widget> _pages = [
    HomePage(),
    MathStorm(),
    ProfilePage(),
    StorePage(),
    LeaderBoard(),
  ];

  void _NavigatedBottomBar(int index) {
    setState(() {
      _selectedIndex = index;

      // Recreate selected page to trigger refresh
      if (index == 0) _pages[0] = HomePage();
      if (index == 1) _pages[1] = MathStorm();
      if (index == 2) _pages[2] = LeaderBoard();
      if (index == 3) _pages[3] = ProfilePage();
      if (index == 4) _pages[4] = StorePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: greyColor,
              width: 2.0,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.white,
            onTap: _NavigatedBottomBar,
            items: [
              /// HOME
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0
                        ? Colors.blue[42]
                        : Colors.transparent,
                    border: _selectedIndex == 0
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/Home.png',
                    width: 42,
                    height: 42,
                  ),
                ),
                label: '',
              ),

              /// Math STORM
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1
                        ? Colors.blue[42]
                        : Colors.transparent,
                    border: _selectedIndex == 1
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/ArifmeticStorm1.png',
                    width: 42,
                    height: 42,
                  ),
                ),
                label: '',
              ),
              
              /// LEADERBOARD
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 2
                        ? Colors.blue[42]
                        : Colors.transparent,
                    border: _selectedIndex == 2
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/Leaderboard.png',
                    width: 42,
                    height: 42,
                  ),
                ),
                label: '',
              ),

              /// PROFILE
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 3
                        ? Colors.blue[42]
                        : Colors.transparent,
                    border: _selectedIndex == 3
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/Profile.png',
                    width: 42,
                    height: 42,
                  ),
                ),
                label: '',
              ),

      

              /// STORE
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 4
                        ? Colors.blue[42]
                        : Colors.transparent,
                    border: _selectedIndex == 4
                        ? Border.all(color: primaryColor, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/icons/Store.png',
                    width: 42,
                    height: 42,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
