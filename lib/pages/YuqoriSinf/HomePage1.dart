import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/savollar/YuqoriSinfSavollar/NaturalSonlar1.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/components/font.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:alochi_math_app/pages/NotificationsPage.dart';
import 'package:flutter/material.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int filledSegments = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconWithValue('assets/icons/Heart.png', '${GameState.hearts}', red),
            _iconWithValue('assets/icons/Diamond.png', '${GameState.gems}', green),
            _iconWithValue('assets/icons/Lightining.png', '${GameState.lightnings}', primaryPurple),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (_, __, ___) => const NotificationsPage(),
                  transitionsBuilder: (_, animation, __, child) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                    child: child,
                  ),
                ),
              ),
              child: Image.asset('assets/icons/Ring.png', width: 32, height: 32),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(color: greyColor, height: 2.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/1.png',
                  height: 80,
                  width: 150,
                ),
                Text(
                  S.of(context).beshinchiSinf,
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: BoldFont,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NaturalSonlar1()));
                  },
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/1progress.png', // ✅ Make sure path is correct
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Text(
                            S.of(context).naturalSonlar,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // To be readable on image
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      // Background bar
                      Container(
                        width: double.infinity,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: greyColor,
                        ),
                        child: Row(
                          children: List.generate(10, (index) {
                            bool isFilled = index < filledSegments;

                            // Round left side only for the first segment
                            bool isFirstSegment = index == 0;

                            // Round right side only if this is the last segment and all are filled
                            bool isLastSegment = index == 9 && filledSegments == 10;

                            return Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isFilled ? primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: isFirstSegment ? Radius.circular(20) : Radius.zero,
                                    bottomLeft: isFirstSegment ? Radius.circular(20) : Radius.zero,
                                    topRight: isLastSegment ? Radius.circular(20) : Radius.zero,
                                    bottomRight: isLastSegment ? Radius.circular(20) : Radius.zero,
                                  ),
                                  border: Border(
                                    right: index < 9
                                        ? const BorderSide(color: Colors.white, width: 1.5)
                                        : BorderSide.none,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Matnli masalalar
                LessonCard(
                  title: S.of(context).matnliMasalalar,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //geometriya
                LessonCard(
                  title: S.of(context).geometriya,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //oddiy Kasrlar
                LessonCard(
                  title: S.of(context).oddiyKasrlar,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //fazoviy Shakllar
                LessonCard(
                  title: S.of(context).fazoviyShakllar,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //onli Kasrlar
                LessonCard(
                  title: S.of(context).onliKasrlar,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //malumotlar Tahlili
                LessonCard(
                  title: S.of(context).malumotlarTahlili,
                  imagePath: 'assets/images/1progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),

                ///////////////////////////////////////////////////////////////////////////////////
                // 6 sinf
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/2.png',
                  height: 90,
                  width: 160,
                ),
                Text(
                  S.of(context).oltinchiSinf,
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: BoldFont,
                    color: purpleContainer,
                  ),
                ),
                const SizedBox(height: 10),
                //har Xil Maxrajli Kasrlar
                LessonCard(
                  title: S.of(context).harXilMaxrajliKasrlar,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //kasrlarni Kopaytirish Bolish
                LessonCard(
                  title: S.of(context).kasrlarniKopaytirishBolish,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //nisbat Va Proporsiya
                LessonCard(
                  title: S.of(context).nisbatVaProporsiya,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //butun Sonlar
                LessonCard(
                  title: S.of(context).butunSonlar,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //ratsional Sonlar
                LessonCard(
                  title: S.of(context).ratsionalSonlar,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //tenglamalar
                LessonCard(
                  title: S.of(context).tenglamalar,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //malumotlar Bilan Ishlash
                LessonCard(
                  title: S.of(context).malumotlarBilanIshlash,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //geometrik Material
                LessonCard(
                  title: S.of(context).geometrikMaterial,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //tenglamalar
                LessonCard(
                  title: S.of(context).tenglamalar,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //yakuniy Takrorlash
                LessonCard(
                  title: S.of(context).yakuniyTakrorlash,
                  imagePath: 'assets/images/2progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),

                ///////////////////////////////////////////////////////////////////////////////////
                // 7 sinf
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/3.png',
                  height: 100,
                  width: 150,
                ),
                Text(
                  S.of(context).yetinchiSinf,
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: BoldFont,
                    color: orange,
                  ),
                ),
                const SizedBox(height: 10),
                //algebraik Ifodalar
                LessonCard(
                  title: S.of(context).algebraikIfodalar,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //birinchi Darajali Tenglamalar
                LessonCard(
                  title: S.of(context).birinchiDarajaliTenglamalar,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //birhadlar Va Kophadlar
                LessonCard(
                  title: S.of(context).birhadlarVaKophadlar,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //kophadni Ajratish
                LessonCard(
                  title: S.of(context).kophadniAjratish,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //kombinatorika
                LessonCard(
                  title: S.of(context).kombinatorika,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //kombinatorika
                LessonCard(
                  title: S.of(context).kombinatorika,
                  imagePath: 'assets/images/3progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),

                ///////////////////////////////////////////////////////////////////////////////////
                // 8 sinf
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/4.png',
                  height: 100,
                  width: 150,
                ),
                Text(
                  S.of(context).sakkizinchiSinf,
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: BoldFont,
                    color: greenAlmaz,
                  ),
                ),
                const SizedBox(height: 10),
                //algebraik Kasrlar Va Ratsional Ifodalar
                LessonCard(
                  title: S.of(context).algebraikKasrlarVaRatsionalIfodalar,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //darajalar Va Ildizlar
                LessonCard(
                  title: S.of(context).darajalarVaIldizlar,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //funksiyasi
                LessonCard(
                  title: S.of(context).funksiyasi,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //tengsizliklar
                LessonCard(
                  title: S.of(context).tengsizliklar,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //kvadrat Tenglamalar
                LessonCard(
                  title: S.of(context).kvadratTenglamalar,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //taqribiy Hisoblash Va Xatoliklar
                LessonCard(
                  title: S.of(context).taqribiyHisoblashVaXatoliklar,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //malumotlar Tahlili
                LessonCard(
                  title: S.of(context).malumotlarTahlili,
                  imagePath: 'assets/images/4progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),

                ///////////////////////////////////////////////////////////////////////////////////
                // 9 sinf
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/5.png',
                  height: 150,
                  width: 140,
                ),
                Text(
                  S.of(context).toqqizinchiSinf,
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: BoldFont,
                    color: primaryYellow,
                  ),
                ),
                const SizedBox(height: 10),
                //kvadrat Funksiya Ta Tengsizliklar
                LessonCard(
                  title: S.of(context).kvadratFunksiyaTaTengsizliklar,
                  imagePath: 'assets/images/5progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //tenglamalar Va Tengsizliklar Sistemalari
                LessonCard(
                  title: S.of(context).tenglamalarVaTengsizliklarSistemalari,
                  imagePath: 'assets/images/5progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //trigonometriya Asoslari
                LessonCard(
                  title: S.of(context).trigonometriyaAsoslari,
                  imagePath: 'assets/images/5progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //sonli Ketma Ketliklar
                LessonCard(
                  title: S.of(context).sonliKetmaKetliklar,
                  imagePath: 'assets/images/5progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
                //ehtimollar Va Statistik
                LessonCard(
                  title: S.of(context).ehtimollarVaStatistik,
                  imagePath: 'assets/images/5progress.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NaturalSonlar1()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconWithValue(String path, String value, Color color) {
    return Row(
      children: [
        Image.asset(path, width: 32, height: 32),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 18.0,
            fontFamily: BoldFont,
            color: color,
          ),
        ),
      ],
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const LessonCard({
    Key? key,
    required this.title,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, 
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: greyColor,
          ),
          child: Row(
            children: List.generate(10, (index) {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: index < 9
                          ? const BorderSide(color: Colors.white, width: 1.5)
                          : BorderSide.none,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
