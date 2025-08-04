// ignore_for_file: deprecated_member_use

import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:flutter/material.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Followers', 'Following'];

  @override
  Widget build(BuildContext context) {
    final tabWidth = MediaQuery.of(context).size.width / _titles.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'Friends',
              style: TextStyle(
                color: darkGrey,
                fontFamily: BoldFont,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back, color: darkGrey),
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
      body: Column(
        children: [
          // Tab bar with grey underline under all tabs and sliding colored underline
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // Tabs with fixed grey underlines
              Row(
                children: List.generate(_titles.length, (index) {
                  final isSelected = index == _selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              _titles[index],
                              style: TextStyle(
                                fontFamily: Font,
                                fontSize: 20,
                                color: isSelected ? primaryColor : darkGrey,
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              // Sliding colored underline
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _selectedIndex * tabWidth,
                bottom: 0,
                child: Container(
                  width: tabWidth,
                  height: 2,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // TAB CONTENT AREA — Add content here for each tab
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                // Tab 0: Followers
                Center(
                  child: Text(
                    'Followers content goes here',
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 18,
                      color: darkGrey,
                    ),
                  ),
                ),

                // Tab 1: Following
                Center(
                  child: Text(
                    'Following content goes here',
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 18,
                      color: darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
