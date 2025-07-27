import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/PremiumPage2.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:animated_button/animated_button.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).magazin,
          style: TextStyle(
            fontFamily: BoldFont,
            color: darkGrey,
            fontSize: 20,
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
                                  'We are boosting your progress!',
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
                                  'Get unlimited hearts and attempts in MathStorm.',
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
                          Image.asset(
                            'assets/storeImages/AlochiInfinity2.png',
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
                                  pageBuilder: (context, animation, secondaryAnimation) => PremiumPage2(),
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Offers',
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
                          'assets/storeImages/Box.png',
                          height: 70,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Light Box',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: Font,
                                    color: questionColor
                                  ),
                                ),
                                Text(
                                  'To open the box, complete the lesson from 6 a.m. to noon.',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: Font,
                                    color: darkGrey
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'OPEN',
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 20,
                                    color: primaryColor
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
              
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          'assets/storeImages/Box2.png',
                          height: 70,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Night Box',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: Font,
                                    color: questionColor
                                  ),
                                ),
                                Text(
                                  'To open the box, complete the lesson from 6 p.m. to midnight.',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: Font,
                                    color: darkGrey
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'OPEN',
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 20,
                                    color: primaryColor
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

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Lightning streak',
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/storeImages/Freezing.png',
                            height: 90,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Freezing',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: Font,
                                    color: questionColor
                                  ),
                                ),
                                Text(
                                  'Freeze your lightning streak in case you miss a class.',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: Font,
                                    color: darkGrey
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/Diamond.png',
                                      height: 30,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '200',
                                      style: TextStyle(
                                        fontFamily: Font,
                                        fontSize: 16,
                                        color: green
                                      ),
                                    ),
                                  ],
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

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gems',
                    style: TextStyle(
                      fontFamily: Font,
                      fontSize: 26,
                      color: questionColor
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hearts',
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
                                  'Unlimited hearts',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: Font,
                                    color: questionColor
                                  ),
                                ),
                                Text(
                                  'A\'lochi Infinity: don\'t worry about your hearts!',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: Font,
                                    color: darkGrey
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'LET\'S TRY',
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 20,
                                    color: primaryColor
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

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          'assets/icons/Heart.png',
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
                                  'Hearts',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: Font,
                                    color: questionColor
                                  ),
                                ),
                                Text(
                                  'Restore maximum hearts and don\'t worry about the mistakes you made',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: Font,
                                    color: darkGrey
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'FULL HERTS',
                                  style: TextStyle(
                                    fontFamily: Font,
                                    fontSize: 20,
                                    color: grey
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
            
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
