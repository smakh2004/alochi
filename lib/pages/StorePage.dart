import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/GameState.dart';
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

      // App bar at the top of the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          S.of(context).magazin,
          style: TextStyle(
            fontFamily: primaryFont,
            color: darkGrey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Diamond icon and balance shown on top right
          Row(
            children: [
              Image.asset('assets/icons/Diamond.png', width: 28, height: 28),
              const SizedBox(width: 4),
              Text(
                GameState.gems.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontSize: 16.0,
                  fontFamily: primaryFont,
                  color: green,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        // Bottom border line under AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(height: 2, color: greyColor),
        ),
      ),

      // Body content inside a scrollable ListView
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            children: [
              // Title: Mening narsalarim
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).magazin,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Horizontal list of owned items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    _buildAnimatedItem('assets/items/MrSquareBoost.png', S.of(context).kvadratBust, '2XP', Icons.bolt),
                    const SizedBox(width: 15),
                    _buildAnimatedItem('assets/items/MrSquareTime.png', S.of(context).kvadratVaqt, '40 ${S.of(context).sekund}', Icons.access_time),
                    const SizedBox(width: 15),
                    _buildAnimatedItem('assets/items/MrSquareBox.png', S.of(context).kvadratSandiq, '4X', null),
                    const SizedBox(width: 15),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Title: Jonlar zapasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).jonlarZapasi,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Horizontal list of owned items (Jonlar Zapasi)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    _buildAnimatedItem3(
                      'assets/icons/Heart.png',
                      S.of(context).jon,
                      '1X',
                      Icons.favorite,
                      cost: '10',
                    ),
                    const SizedBox(width: 15),
                    _buildAnimatedItem3(
                      'assets/items/SavatHeart.png',
                      S.of(context).savatJon,
                      '5X',
                      Icons.favorite,
                      cost: '50',
                    ),
                    const SizedBox(width: 15),
                    _buildAnimatedItem3(
                      'assets/items/SandiqHeart.png',
                      S.of(context).sandiqJon,
                      '10X',
                      Icons.favorite,
                      cost: '100',
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // First banner section: Kvadrat Qasri
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _buildBannerSection(
                  title: S.of(context).kvadratQasriXazinalari,
                  imagePath: 'assets/images/MrSquareBoxBanner.png',
                  itemPaths: [
                    'assets/items/MrSquareBox.png',
                    'assets/items/MrSquareTime.png',
                    'assets/items/MrSquareBoost.png'
                  ],
                  itemNames: [S.of(context).kvadratSandiq, S.of(context).kvadratVaqt, S.of(context).kvadratBust],
                  itemNumber: ['1X', '40 ${S.of(context).sekund}', '2XP'],
                  itemCost: ['30', '10', '50'],
                  textColor: primaryColor,
                  isDisabled: false,
                ),
              ),

              const SizedBox(height: 40),

              // Second banner section: Uchburchak Piramidasi (disabled)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _buildBannerSection(
                  title: S.of(context).uchburchakPiramidasiXazinalari,
                  imagePath: 'assets/images/MrTriangleBoxBanner.png',
                  itemPaths: [
                    'assets/items/MrTriangleBox.png',
                    'assets/items/MrTriangleTime.png',
                    'assets/items/MrTriangleBoost.png',
                  ],
                  itemNames: [S.of(context).uchburchakSandiq, S.of(context).uchburchakVaqt, S.of(context).uchburchakBust],
                  itemNumber: ['1X', '60 ${S.of(context).sekund}', '3XP'],
                  itemCost: ['60', '20', '80'],
                  textColor: primaryPurple,
                  isDisabled: true, // disables interaction and dims visuals
                ),
              ),

              const SizedBox(height: 40),

            ],
          );
        },
      ),
    );
  }

  // Widget for a small horizontal card in the personal items section
  Widget _buildAnimatedItem(String assetPath, String name, String number, IconData? icon) {
    return AnimatedButton(
      width: 140,
      height: 160,
      color: Colors.white,
      shadowDegree: ShadowDegree.light,
      onPressed: () {
        // Show purchase confirmation dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: EdgeInsets.zero,
                content: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 300, // fix width so Positioned works reliably
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: grey, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 12),
                          Image.asset(assetPath, width: 120, height: 120),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                              children: [
                                TextSpan(text: '\n${S.of(context).miqdori}: '),
                                TextSpan(text: number, style: TextStyle(color: primaryColor)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          AnimatedButton(
                            width: 120,
                            height: 50,
                            color: primaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                              // TODO: implement purchase logic
                            },
                            child: Text(
                              S.of(context).ishlatish,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    /// ❌ Top-right close button (25% in / 75% out)
                    Positioned(
                      top: -16,
                      right: -16,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: grey, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.close, size: 35, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: greyColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            Image.asset(assetPath, width: 80, height: 80, fit: BoxFit.contain),
            Expanded(child: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            const SizedBox(height: 5),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: primaryColor, size: 18),
                  if (icon != null) const SizedBox(width: 1),
                  Text(number, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for a single vertical purchase card with image, name, cost, and dialog
  Widget _buildAnimatedItem2(String assetPath, String name, String itemNumber, Color textColor, String cost, {bool isDisabled = false}) {
    return AbsorbPointer(
      absorbing: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: AnimatedButton(
          width: 290,
          height: 120,
          color: Colors.white,
          shadowDegree: ShadowDegree.light,
          onPressed: () {
            // Show purchase confirmation dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    contentPadding: EdgeInsets.zero,
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 300, // fixed width to ensure consistent positioning
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: grey,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20)),
                              const SizedBox(height: 12),
                              Image.asset(assetPath, width: 120, height: 120),
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                  children: [
                                    TextSpan(text: '${S.of(context).narxi}: '),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Image.asset(
                                          'assets/icons/Diamond.png',
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                        text: cost,
                                        style: TextStyle(color: primaryCorrect)),
                                    TextSpan(text: '\n${S.of(context).miqdori}: '),
                                    TextSpan(
                                        text: itemNumber,
                                        style: TextStyle(color: primaryColor)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              AnimatedButton(
                                width: 120,
                                height: 50,
                                color: primaryCorrect,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // TODO: implement purchase logic
                                },
                                child: Text(
                                  S.of(context).sotibOlish,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),

                        // ❌ Positioned 25% inside / 75% outside
                        Positioned(
                          top: -16,
                          right: -16,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: grey, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.close, size: 35, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: greyColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Item image with grayscale effect if disabled
                ColorFiltered(
                  colorFilter: isDisabled
                      ? const ColorFilter.matrix(<double>[0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0])
                      : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: Image.asset(assetPath, width: 80, height: 100, fit: BoxFit.contain),
                ),
                const SizedBox(width: 12),

                // Item name and stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDisabled ? Colors.grey : Colors.black)),
                      const SizedBox(height: 4),
                      Text(itemNumber, style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // Diamond icon and price
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ColorFiltered(
                      colorFilter: isDisabled
                          ? const ColorFilter.matrix(<double>[0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0])
                          : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                      child: Image.asset('assets/icons/Diamond.png', width: 30, height: 30, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 4),
                    Text(cost, style: TextStyle(fontSize: 16, color: isDisabled ? Colors.grey : primaryCorrect, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedItem3(
    String assetPath,
    String name,
    String number,
    IconData? icon, {
    String? cost,
  }) {
    return AnimatedButton(
      width: 140,
      height: 160,
      color: Colors.white,
      shadowDegree: ShadowDegree.light,
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: EdgeInsets.zero,
                content: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: grey, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 12),
                          Image.asset(assetPath, width: 120, height: 120),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                              children: [
                                TextSpan(text: '\n${S.of(context).miqdori}: '),
                                TextSpan(text: number, style: TextStyle(color: primaryIncorrect)),
                                if (cost != null) ...[
                                  TextSpan(text: '\n${S.of(context).narxi}: '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset('assets/icons/Diamond.png', width: 16, height: 16),
                                        const SizedBox(width: 4),
                                        Text(cost, style: TextStyle(color: primaryCorrect, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          AnimatedButton(
                            width: 120,
                            height: 50,
                            color: primaryCorrect,
                            onPressed: () {
                              Navigator.of(context).pop();
                              // TODO: implement purchase logic
                            },
                            child: Text(
                              S.of(context).sotibOlish,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    Positioned(
                      top: -16,
                      right: -16,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: grey, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.close, size: 35, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: greyColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            Image.asset(assetPath, width: 80, height: 80, fit: BoxFit.contain),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: primaryIncorrect, size: 18),
                  if (icon != null) const SizedBox(width: 1),
                  Text(number, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryIncorrect)),
                  if (cost != null) ...[
                    const SizedBox(width: 15),
                    Image.asset('assets/icons/Diamond.png', width: 18, height: 18),
                    const SizedBox(width: 2),
                    Text(cost, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryCorrect)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget for full banner section with title, image, and multiple items
  Widget _buildBannerSection({
    required String title,
    required String imagePath,
    required List<String> itemPaths,
    required List<String> itemNames,
    required List<String> itemNumber,
    required List<String> itemCost,
    required Color textColor,
    bool isDisabled = false,
  }) {
    return AbsorbPointer(
      absorbing: isDisabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDisabled ? Colors.grey : Colors.black)),
          const SizedBox(height: 10),

          // Banner box with image and list of items
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: greyColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Banner image with optional dimming
                  ColorFiltered(
                    colorFilter: isDisabled
                        ? const ColorFilter.matrix(<double>[0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0.2126, 0.7152, 0.0722, 0, 0, 0, 0, 0, 1, 0])
                        : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                    child: Opacity(
                      opacity: isDisabled ? 0.4 : 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(imagePath, height: 160, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Items listed in a wrap layout
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: List.generate(itemPaths.length, (index) {
                      return _buildAnimatedItem2(
                        itemPaths[index],
                        itemNames[index],
                        itemNumber[index],
                        isDisabled ? Colors.grey : textColor,
                        itemCost[index],
                        isDisabled: isDisabled,
                      );
                    }),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
