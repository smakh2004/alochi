// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_final_fields
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/MathStorm/MathStorm.dart';
import 'package:alochi_math_app/pages/BoshlangichSinf/HomePage.dart';
import 'package:alochi_math_app/pages/Connectivity.dart';
import 'package:alochi_math_app/pages/LeaderBoard.dart';
import 'package:alochi_math_app/pages/NoInternetPage.dart';
import 'package:alochi_math_app/pages/ProfilePage.dart';
import 'package:alochi_math_app/pages/StorePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoshlangichSinf extends StatefulWidget {
  const BoshlangichSinf({super.key});

  @override
  State<BoshlangichSinf> createState() => _BoshlangichSinfState();
}

class _BoshlangichSinfState extends State<BoshlangichSinf> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    MathStorm(),
    LeaderBoard(),
    ProfilePage(),
    StorePage(),
  ];

  void _NavigatedBottomBar(int index) {
    setState(() {
      _selectedIndex = index;

      // Refresh page content manually if needed
      if (index == 0) _pages[0] = HomePage();
      if (index == 1) _pages[1] = MathStorm();
      if (index == 2) _pages[2] = LeaderBoard();
      if (index == 3) _pages[3] = ProfilePage();
      if (index == 4) _pages[4] = StorePage();
    });
  }

  Widget _buildIcon(int index, String assetPath) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _selectedIndex == index ? lightBlue : Colors.transparent,
        border: _selectedIndex == index
            ? Border.all(color: primaryColor, width: 2)
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        width: 40,
        height: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access hasConnection from Provider here
    final hasConnection = context.watch<ConnectivityService>().hasConnection;

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
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              if (!hasConnection) {
                // Navigate to NoInternetPage if no internet connection
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NoInternetPage()),
                );
                return;
              }
              _NavigatedBottomBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(0, 'assets/icons/Home.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(1, 'assets/icons/ArifmeticStorm1.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(2, 'assets/icons/Leaderboard.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(3, 'assets/icons/Profile.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(4, 'assets/icons/Store.png'),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
