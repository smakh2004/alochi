import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  int selectedIndex = 0;

  Stream<QuerySnapshot> getLeaderboardStream() {
    if (selectedIndex == 0) {
      return FirebaseFirestore.instance
          .collection('users')
          .orderBy('matematikShtorm', descending: true)
          .limit(50)
          .snapshots();
    } else if(selectedIndex == 1) {
      return FirebaseFirestore.instance
          .collection('users')
          .orderBy('score', descending: true)
          .limit(50)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .orderBy('lightnings', descending: true)
          .limit(50)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            S.of(context).leaderboard,
            style: TextStyle(
              fontFamily: BoldFont,
              color: darkGrey,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Lottie.asset(
              'assets/animations/BannerLeaderboard.json',
              width: 330,
              fit: BoxFit.contain,
            ),
          ),
          // Current user position
          StreamBuilder<QuerySnapshot>(
            stream: getLeaderboardStream(),
            builder: (context, snapshot) {
              int? currentUserPosition;
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final docs = snapshot.data!.docs;
                for (int i = 0; i < docs.length; i++) {
                  if (docs[i].id == currentUserId) {
                    currentUserPosition = i + 1;
                    break;
                  }
                }
              }

              return Text(
                currentUserPosition != null
                  ? '${S.of(context).youAreIn} $currentUserPosition${S.of(context).place}'
                  : S.of(context).SizHali,
                style: const TextStyle(
                  fontFamily: Font,
                  fontSize: 20,
                  color: questionColor,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),

          // Dropdown separate from main wrapper
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: greyColor, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  value: selectedIndex,
                  isExpanded: true,
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: questionColor),
                  ),
                  style: const TextStyle(
                    fontFamily: Font,
                    fontSize: 16,
                    color: questionColor,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Image.asset('assets/icons/ArifmeticStorm.png',
                              width: 30, height: 30),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).matematikShtorm,
                            style: const TextStyle(
                              fontFamily: Font,
                              fontSize: 18,
                              color: questionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Image.asset('assets/icons/Points.png',
                              width: 30, height: 30),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).score,
                            style: const TextStyle(
                              fontFamily: Font,
                              fontSize: 18,
                              color: questionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Image.asset('assets/icons/Lightining.png',
                              width: 30, height: 30),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).streak,
                            style: const TextStyle(
                              fontFamily: Font,
                              fontSize: 18,
                              color: questionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedIndex = value;
                      });
                    }
                  },
                  dropdownStyleData: DropdownStyleData(
                    elevation: 0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: greyColor, width: 2),
                    ),
                    // Match the menu width to the button width
                    width: MediaQuery.of(context).size.width - 32, 
                    offset: const Offset(-18, -10), // adjust 
                  ),
                ),
              ),
            ),
          ),

          // Main leaderboard list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getLeaderboardStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noDataFound,
                      style: TextStyle(
                        fontFamily: Font,
                        fontSize: 18,
                        color: questionColor,
                      ),
                    ),
                  );
                }

                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: greyColor,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final data =
                              doc.data() as Map<String, dynamic>;
                          final firstName = data['firstName'] ?? '';
                          final lastName = data['lastName'] ?? '';
                          final value = selectedIndex == 0
                          ? (data['matematikShtorm'] ?? 0)
                          : selectedIndex == 1
                              ? (data['score'] ?? 0)
                              : (data['lightnings'] ?? 0);
                          final bool isCurrentUser =
                              doc.id == currentUserId;

                          Widget leadingWidget;
                          if (index == 0) {
                            leadingWidget = Image.asset(
                              'assets/images/Gold.png',
                              height: 30,
                              width: 30,
                            );
                          } else if (index == 1) {
                            leadingWidget = Image.asset(
                              'assets/images/Silver.png',
                              height: 30,
                              width: 30,
                            );
                          } else if (index == 2) {
                            leadingWidget = Image.asset(
                              'assets/images/Bronze.png',
                              height: 30,
                              width: 30,
                            );
                          } else {
                            leadingWidget = SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: questionColor,
                                    fontFamily: BoldFont,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Container(
                            color: isCurrentUser
                                ? lightGrey
                                : Colors.transparent,
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              leading: leadingWidget,
                              title: Text(
                                '$firstName $lastName',
                                style: const TextStyle(
                                  fontFamily: Font,
                                  fontSize: 18,
                                  color: questionColor,
                                ),
                              ),
                              trailing: Text(
                                '$value',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: Font,
                                  color: questionColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
