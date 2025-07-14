import 'package:cloud_firestore/cloud_firestore.dart';

class GameState {

  // Selected level of user: BOSHLANGICH, YUQORISINF, STUDENT
  static String selectedLevel = '';
  static String firstName = ''; 
  static String lastName = '';

  static int matematikShtorm = 0;
  static int mathStormAttemptsLeft = 3;
  static int lastScore = 0;
  static int lastTime = 0;

  // progress for Boshlangich
  static double currentXP = 0;
  static double maxXP = 100;
  static double TcurrentXP = 0;
  static double TmaxXP = 100;
  static int score = 0;
  static int scoreDop = 0;

  static int hearts = 5;
  static int lightnings = 0;
  static int gems = 0;

  static double arifmetika = 0;
  static double arifmetikaMax = 100;
  static double arifmetikaDop = 0;

  static double kopaytirish = 0;
  static double kopaytirishMax = 100;
  static double kopaytirishDop = 0;

  static double logika = 0;
  static double logikaMax = 100;
  static double logikaDop = 0;

  static DateTime? lastLightningDate;
  static DateTime? lastLightningDate1;

  /// RESET values to defaults (except selectedLevel)
  static void reset() {

    matematikShtorm = 0;
    mathStormAttemptsLeft = 3;

    lastScore = 0;
    lastTime = 0;

    currentXP = 0;
    maxXP = 100;

    TcurrentXP = 0;
    TmaxXP = 100;

    hearts = 5;
    lightnings = 0;
    gems = 0;

    score = 0;
    scoreDop = 0;

    arifmetika = 0;
    arifmetikaMax = 100;
    arifmetikaDop = 0;

    kopaytirish = 0;
    kopaytirishMax = 100;
    kopaytirishDop = 0;

    logika = 0;
    logikaMax = 100;
    logikaDop = 0;

    lastLightningDate = null;
    lastLightningDate1 = null;
  }

  /// Save game state to Firestore
  static Future<void> saveState(String userId) async {
    if (userId.isEmpty) return;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'selectedLevel': selectedLevel,
      'firstName': firstName, // Save first name
      'lastName': lastName, // Save last name
      'matematikShtorm': matematikShtorm,
      'mathStormAttemptsLeft': mathStormAttemptsLeft,
      'lastScore': lastScore,
      'lastTime': lastTime,
      'currentXP': currentXP,
      'maxXP': maxXP,
      'TcurrentXP': TcurrentXP,
      'TmaxXP': TmaxXP,
      'hearts': hearts,
      'lightnings': lightnings,
      'gems': gems,
      'score': score,
      'scoreDop': scoreDop,
      'arifmetika': arifmetika,
      'arifmetikaMax': arifmetikaMax,
      'arifmetikaDop': arifmetikaDop,
      'kopaytirish': kopaytirish,
      'kopaytirishMax': kopaytirishMax,
      'kopaytirishDop': kopaytirishDop,
      'logika': logika,
      'logikaMax': logikaMax,
      'logikaDop': logikaDop,
      'lastLightningDate': lastLightningDate?.toIso8601String(),
      'lastLightningDate1': lastLightningDate1?.toIso8601String(),
    }, SetOptions(merge: true));
  }

  /// Load game state from Firestore
  static Future<void> loadState(String userId) async {
    if (userId.isEmpty) return;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) return;

    final data = doc.data()!;

    selectedLevel = data['selectedLevel'] ?? '';
    firstName = data['firstName'] ?? ''; 
    lastName = data['lastName'] ?? ''; 

    matematikShtorm = data['matematikShtorm'] ?? 0;
    mathStormAttemptsLeft = data['mathStormAttemptsLeft'] ?? 3;

    lastScore = data['lastScore'] ?? 0;
    lastTime = data['lastTime'] ?? 0;

    currentXP = (data['currentXP'] ?? 0).toDouble();
    maxXP = (data['maxXP'] ?? 100).toDouble();
    TcurrentXP = (data['TcurrentXP'] ?? 0).toDouble();
    TmaxXP = (data['TmaxXP'] ?? 100).toDouble();

    hearts = data['hearts'] ?? 5;
    lightnings = data['lightnings'] ?? 0;
    gems = data['gems'] ?? 0;

    score = data['score'] ?? 0;
    scoreDop = data['scoreDop'] ?? 0;

    arifmetika = (data['arifmetika'] ?? 0).toDouble();
    arifmetikaMax = (data['arifmetikaMax'] ?? 100).toDouble();
    arifmetikaDop = (data['arifmetikaDop'] ?? 0).toDouble();

    kopaytirish = (data['kopaytirish'] ?? 0).toDouble();
    kopaytirishMax = (data['kopaytirishMax'] ?? 100).toDouble();
    kopaytirishDop = (data['kopaytirishDop'] ?? 0).toDouble();

    logika = (data['logika'] ?? 0).toDouble();
    logikaMax = (data['logikaMax'] ?? 100).toDouble();
    logikaDop = (data['logikaDop'] ?? 0).toDouble();

    lastLightningDate = _parseDate(data['lastLightningDate']);
    lastLightningDate1 = _parseDate(data['lastLightningDate1']);
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
}
