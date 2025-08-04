// ignore_for_file: use_build_context_synchronously

import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/BoxOpenings/BigBoxOpening.dart';
import 'package:alochi_math_app/pages/BoxOpenings/BoxOpening.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/PremiumPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).magazin,
          style: TextStyle(
            fontFamily: BoldFont,
            color: darkGrey,
          ),
        ),
        actions: [
          Row(
            children: [
              Image.asset('assets/icons/Diamond.png', width: 28, height: 28),
              const SizedBox(width: 4),
              Text(
                GameState.gems.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: BoldFont,
                  color: green,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: noInternet,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // center vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //  Left column (image + text)
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // AlochiBanner.png with fixed size
                                Image.asset(
                                  'assets/storeImages/AlochiBanner.png',
                                    width: 120,
                                    fit: BoxFit.contain,
                                ),
                  
                                const SizedBox(height: 8),
                  
                                // Text 1
                                Text(
                                  S.of(context).weAreBoosting,
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 26,
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                  
                                const SizedBox(height: 8),
                  
                                // Text 2
                                Text(
                                  S.of(context).getUnlimited,
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 17,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                  
                          const SizedBox(width: 8),
                  
                          // Right side image (fixed size)
                          Lottie.asset(
                            'assets/animations/AlochiInfinity2.json',
                            height: 220,
                            width: 160,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: AnimatedButton(
                            height: 50,
                            borderRadius: 12,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 600),
                                  pageBuilder: (context, animation, secondaryAnimation) => PremiumPage(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                                    return SlideTransition(
                                      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                S.of(context).yoqish,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: Font,
                                  color: noInternet,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // OFFERS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).offers,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  if (GameState.gems >= 30) {
                    setState(() {
                      GameState.gems -= 30;
                    });

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId != null) {
                      await GameState.saveState(userId);
                    }

                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BoxOpening()),
                    );
                    
                    setState(() {
                    });
                  } else {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/icons/Diamond.png', height: 28),
                                        const SizedBox(width: 4),
                                        Text(
                                          GameState.gems.toString(),
                                          style: TextStyle(
                                            fontFamily: BoldFont,
                                            fontSize: 18,
                                            color: green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        S.of(context).refillYourGems,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: Font,
                                          color: questionColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ...List.generate(3, (index) {
                                      final gemOptions = [
                                        {'amount': '30 ${S.of(context).gems}', 'price': '\$1.99', 'image': 'assets/storeImages/Gems1.png'},
                                        {'amount': '80 ${S.of(context).gems}', 'price': '\$3.99', 'image': 'assets/storeImages/Gems2.png'},
                                        {'amount': '360 ${S.of(context).gems}', 'price': '\$9.99', 'image': 'assets/storeImages/Gems3.png'},
                                      ];
                                      return GestureDetector(
                                        onTap: () => setState(() => selectedOption = index),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 6),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(
                                              color: selectedOption == index ? primaryColor : greyColor,
                                              width: 2.3,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(gemOptions[index]['image']!, height: 60, width: 60),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    gemOptions[index]['amount']!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: Font,
                                                      color: questionColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                gemOptions[index]['price']!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: Font,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 24),
                                    Center(
                                      child: AnimatedButton(
                                        height: 46,
                                        width: 320,
                                        borderRadius: 12,
                                        color: primaryColor,
                                        onPressed: () {
                                          if (selectedOption == -1) {
                                            // show alert
                                          } else {
                                            // handle purchase
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            S.of(context).buyGems,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: Font,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          S.of(context).returnH,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: Font,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/storeImages/Box.png',
                            height: 70,
                            width: 90,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).Box,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: Font,
                                            color: questionColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                          'assets/icons/Diamond.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text(
                                          '30',
                                          style: TextStyle(
                                            fontFamily: BoldFont,
                                            fontSize: 16,
                                            color: green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    S.of(context).BoxDesc,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: Font,
                                      color: darkGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    S.of(context).open,
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: () async {
                  if (GameState.gems >= 80) {
                    setState(() {
                      GameState.gems -= 80;
                    });

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId != null) {
                      await GameState.saveState(userId);
                    }

                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BigBoxOpening()),
                    );
                    
                    setState(() {
                    });
                  } else {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/icons/Diamond.png', height: 28),
                                        const SizedBox(width: 4),
                                        Text(
                                          GameState.gems.toString(),
                                          style: TextStyle(
                                            fontFamily: BoldFont,
                                            fontSize: 18,
                                            color: green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: Text(
                                        S.of(context).refillYourGems,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: Font,
                                          color: questionColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ...List.generate(3, (index) {
                                      final gemOptions = [
                                        {'amount': '30 ${S.of(context).gems}', 'price': '\$1.99', 'image': 'assets/storeImages/Gems1.png'},
                                        {'amount': '80 ${S.of(context).gems}', 'price': '\$3.99', 'image': 'assets/storeImages/Gems2.png'},
                                        {'amount': '360 ${S.of(context).gems}', 'price': '\$9.99', 'image': 'assets/storeImages/Gems3.png'},
                                      ];
                                      return GestureDetector(
                                        onTap: () => setState(() => selectedOption = index),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 6),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(
                                              color: selectedOption == index ? primaryColor : greyColor,
                                              width: 2.3,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(gemOptions[index]['image']!, height: 60, width: 60),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    gemOptions[index]['amount']!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: Font,
                                                      color: questionColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                gemOptions[index]['price']!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: Font,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 24),
                                    Center(
                                      child: AnimatedButton(
                                        height: 46,
                                        width: 320,
                                        borderRadius: 12,
                                        color: primaryColor,
                                        onPressed: () {
                                          if (selectedOption == -1) {
                                            // show alert
                                          } else {
                                            // handle purchase
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            S.of(context).buyGems,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: Font,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          S.of(context).returnH,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: Font,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/storeImages/BigBox.png',
                            height: 70,
                            width: 90,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).BigBox,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: Font,
                                            color: questionColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset(
                                          'assets/icons/Diamond.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text(
                                          '80',
                                          style: TextStyle(
                                            fontFamily: BoldFont,
                                            fontSize: 16,
                                            color: green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    S.of(context).BigBoxDesc,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: Font,
                                      color: darkGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    S.of(context).open,
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // STREAK FREEZER
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).streak,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (GameState.gems < 100 && GameState.activeFreezes != 2) {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {

                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Gems display
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.asset('assets/icons/Diamond.png', height: 28),
                                            const SizedBox(width: 4),
                                            Text(
                                              GameState.gems.toString(),
                                              style: TextStyle(
                                                fontFamily: BoldFont,
                                                fontSize: 18,
                                                color: green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),

                                        // Title
                                        Center(
                                          child: Text(
                                            S.of(context).refillYourGems,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: Font,
                                              color: questionColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        // Option 1: 30 Gems
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedOption = 0;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(
                                                color: selectedOption == 0 ? primaryColor : greyColor,
                                                width: 2.3,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset('assets/storeImages/Gems1.png', height: 60, width: 60),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '30 ${S.of(context).gems}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: Font,
                                                        color: questionColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '\$1.99',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: Font,
                                                    color: darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Option 2: 80 Gems
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedOption = 1;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(
                                                color: selectedOption == 1 ? primaryColor : greyColor,
                                                width: 2.3,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset('assets/storeImages/Gems2.png', height: 60, width: 60), 
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '80 ${S.of(context).gems}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: Font,
                                                        color: questionColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '\$3.99',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: Font,
                                                    color: darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Option 3: 360 Gems
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedOption = 2;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(
                                                color: selectedOption == 2 ? primaryColor : greyColor,
                                                width: 2.3,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset('assets/storeImages/Gems3.png', height: 60, width: 60), // Different icon
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '360 ${S.of(context).gems}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: Font,
                                                        color: questionColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '\$9.99',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: Font,
                                                    color: darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 24),

                                        // Buy button
                                        Center(
                                          child: AnimatedButton(
                                            height: 46,
                                            width: 320,
                                            borderRadius: 12,
                                            color: primaryColor,
                                            onPressed: () {
                                              if (selectedOption == -1) {
                                                // Show alert or warning
                                              } else {
                                                // Handle purchase
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                S.of(context).buyGems,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: Font,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        // Return
                                        Center(
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Text(
                                              S.of(context).returnH,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: Font,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else if (GameState.gems >= 100 && GameState.activeFreezes < 2){
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setModalState) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Price aligned to top right
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Diamond.png',
                                              height: 28,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              GameState.gems.toString(),
                                              style: TextStyle(
                                                fontFamily: BoldFont,
                                                fontSize: 18,
                                                color: green,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        // Title text
                                        Center(
                                          child: Text(
                                            S.of(context).keepYourWinStreakSafe,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: Font,
                                              color: questionColor,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        // Description
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: S.of(context).eachFreeze,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '${GameState.activeFreezes} ${S.of(context).ofTwoEquiped}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 24),

                                        // Dynamic Image
                                        Center(
                                          child: Image.asset(
                                            GameState.activeFreezes == 0
                                                ? 'assets/storeImages/FreezePop1.png'
                                                : GameState.activeFreezes == 1
                                                    ? 'assets/storeImages/FreezePop2.png'
                                                    : 'assets/storeImages/FreezePop3.png',
                                            height: 130,
                                          ),
                                        ),

                                        const SizedBox(height: 24),

                                        // Animated Button
                                        Center(
                                          child: AnimatedButton(
                                            height: 46,
                                            width: 310,
                                            borderRadius: 12,
                                            color: primaryColor,
                                            onPressed: () async {
                                              if (GameState.activeFreezes >= 2) {
                                                Navigator.pop(context);
                                                return;
                                              }

                                              if (GameState.gems < 100) {
                                                Navigator.pop(context);
                                                return;
                                              }

                                              setState(() {
                                                // Update values
                                                GameState.gems -= 100;
                                                GameState.activeFreezes += 1;
                                              });

                                              // Save state to Firebase
                                              final userId = FirebaseAuth.instance.currentUser?.uid;
                                              if (userId != null) {
                                                await GameState.saveState(userId);
                                              }

                                              // Trigger UI rebuild inside modal
                                              setModalState(() {});
                                            },
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    S.of(context).refilYourFreeze,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: Font,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Image.asset(
                                                    'assets/storeImages/WhiteGem.png',
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    '100',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: BoldFont,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        // No thanks button
                                        Center(
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Text(
                                              S.of(context).noThanks,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: Font,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/storeImages/Freezing.png',
                              height: 90,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).freezing,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: Font,
                                          color: questionColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'assets/icons/Diamond.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontFamily: BoldFont,
                                          fontSize: 16,
                                          color: green,
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                                  Text(
                                    S.of(context).freezingDesc,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: Font,
                                      color: darkGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GameState.activeFreezes < 1
                                  ? Row(
                                      children: [    
                                        Text(
                                          S.of(context).use,
                                          style: TextStyle(
                                            fontFamily: Font,
                                            fontSize: 20,
                                            color: primaryColor
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                    decoration: BoxDecoration(
                                      color: lightGreen,
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${S.of(context).activated} ${GameState.activeFreezes}/2',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: Font,
                                                  color: greenNew
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).gems,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // GEMS
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      )
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/storeImages/Gems11.png',
                          height: 90,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '30',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 20,
                            color: questionColor
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '1.99\$',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 16,
                            color: primaryColor
                          ),
                        ),
                        SizedBox(height: 5),
                      ]
                    ),
                  ),
                  
                  SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      )
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/storeImages/Gems2.png',
                          height: 90,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '80',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 20,
                            color: questionColor
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '3.99\$',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 16,
                            color: primaryColor
                          ),
                        ),
                        SizedBox(height: 5),
                      ]
                    ),
                  ),
                  SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      )
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/storeImages/Gems3.png',
                          height: 90,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '360',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 20,
                            color: questionColor
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '9.99\$',
                          style: TextStyle(
                            fontFamily: Font,
                            fontSize: 16,
                            color: primaryColor
                          ),
                        ),
                        SizedBox(height: 5),
                      ]
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              
              // JONLAR ZAPASI
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).jonlarZapasi,
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) => const PremiumPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
                          return SlideTransition(
                            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/HeartInfinity.png',
                            height: 75,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).cheksizJonlar,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: Font,
                                      color: questionColor
                                    ),
                                  ),
                                  Text(
                                    S.of(context).cheksizJonlarDesc,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: Font,
                                      color: darkGrey
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    S.of(context).letsTry,
                                    style: TextStyle(
                                      fontFamily: Font,
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    if (GameState.hearts != 5 && GameState.gems >= 50) {
                      setState(() {
                        GameState.gems -= 50;
                        GameState.hearts = 5;
                      });
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      await GameState.saveState(userId);
                    } else if (GameState.hearts != 5 && GameState.gems < 50){
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 16,
                                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset('assets/icons/Diamond.png', height: 28),
                                          const SizedBox(width: 4),
                                          Text(
                                            GameState.gems.toString(),
                                            style: TextStyle(
                                              fontFamily: BoldFont,
                                              fontSize: 18,
                                              color: green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Center(
                                        child: Text(
                                          S.of(context).refillYourGems,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: Font,
                                            color: questionColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ...List.generate(3, (index) {
                                        final gemOptions = [
                                          {'amount': '30 ${S.of(context).gems}', 'price': '\$1.99', 'image': 'assets/storeImages/Gems1.png'},
                                          {'amount': '80 ${S.of(context).gems}', 'price': '\$3.99', 'image': 'assets/storeImages/Gems2.png'},
                                          {'amount': '360 ${S.of(context).gems}', 'price': '\$9.99', 'image': 'assets/storeImages/Gems3.png'},
                                        ];
                                        return GestureDetector(
                                          onTap: () => setState(() => selectedOption = index),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(
                                                color: selectedOption == index ? primaryColor : greyColor,
                                                width: 2.3,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(gemOptions[index]['image']!, height: 60, width: 60),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      gemOptions[index]['amount']!,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: Font,
                                                        color: questionColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  gemOptions[index]['price']!,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: Font,
                                                    color: darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 24),
                                      Center(
                                        child: AnimatedButton(
                                          height: 46,
                                          width: 320,
                                          borderRadius: 12,
                                          color: primaryColor,
                                          onPressed: () {
                                            if (selectedOption == -1) {
                                              // show alert
                                            } else {
                                              // handle purchase
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              S.of(context).buyGems,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: Font,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Text(
                                            S.of(context).returnH,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: Font,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: greyColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/icons/Heart.png', height: 75),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).hearts,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: Font,
                                          color: questionColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'assets/icons/Diamond.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        '50',
                                        style: TextStyle(
                                          fontFamily: BoldFont,
                                          fontSize: 16,
                                          color: green,
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                                  
                                  Text(
                                    S.of(context).heartsDesc,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: Font,
                                      color: darkGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GameState.hearts != 5
                                      ? Row(
                                          children: [
                                            Text(
                                              S.of(context).refillHearts,
                                              style: TextStyle(
                                                fontFamily: Font,
                                                fontSize: 20,
                                                color: primaryColor
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          S.of(context).fullHearts,
                                          style: TextStyle(
                                            fontFamily: Font,
                                            fontSize: 20,
                                            color: grey,
                                          ),
                                        ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
