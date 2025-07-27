// ignore_for_file: unnecessary_null_comparison

import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, String>> notifications = [];
  List<bool> _showNotifications = [];

  @override
  void initState() {
    super.initState();
    // Wait until the first frame to safely use `context` for localization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        notifications = [
          {
            'image': 'assets/images/MrCircleBanner.png',
            'text': S.of(context).notification1,
          },
          {
            'image': 'assets/images/MrSquareBanner.png',
            'text': S.of(context).notification2,
          },
          {
            'image': 'assets/images/MrTriangleBanner.png',
            'text': S.of(context).notification3,
          },
        ];
        _showNotifications = List<bool>.filled(notifications.length, true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Widget> notificationWidgets = [];

    for (int i = 0; i < notifications.length; i++) {
      if (_showNotifications[i]) {
        notificationWidgets.add(
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      notifications[i]['image']!,
                      fit: BoxFit.cover,
                      height: 190,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          notifications[i]['text']!,
                          style: const TextStyle(fontSize: 18, fontFamily: Font, color: questionColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        AnimatedButton(
                          height: 50,
                          width: 100,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _showNotifications[i] = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontFamily: Font,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              S.of(context).xabarlar,
              style: TextStyle(
                color: darkGrey,
                fontFamily: BoldFont,
                fontSize: 18,
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
      body: notifications.isEmpty
          ? SizedBox(
              height: screenHeight * 0.7,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : notificationWidgets.any((widget) => widget != null)
              ? SingleChildScrollView(
                  child: Center(
                    child: Column(children: notificationWidgets),
                  ),
                )
              : SizedBox(
                  height: screenHeight * 0.7,
                  child: const Center(
                    child: Text(
                      "Xabar yo'q",
                      style: TextStyle(fontSize: 20, color: grey, fontFamily: Font,),
                    ),
                  ),
                ),
    );
  }
}
