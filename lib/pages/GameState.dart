import 'package:cloud_firestore/cloud_firestore.dart';

class GameState {
  // Freezers
  static int activeFreezes = 0;

  // Selected level of user
  static String selectedLevel = '';
  static String firstName = '';
  static String lastName = '';

  // Math storm
  static int matematikShtorm = 0;
  static int mathStormAttemptsLeft = 3;
  static int lastScore = 0;
  static int lastTime = 0;
  static DateTime? mathStormTimer;

  // XP progress
  static double currentXP = 0;
  static double maxXP = 100;
  static double currentXP2 = 0;
  static double maxXP2 = 100;
  static double currentXP3 = 0;
  static double maxXP3 = 100;
  static double currentXP4 = 0;
  static double maxXP4 = 100;

  // Score
  static int score = 0;
  static int scoreDop = 0;

  // Game resources
  static int hearts = 5;
  static int lightnings = 0;
  static int gems = 0;

  // Subject stats
  static double arifmetika = 0;
  static double arifmetikaDop = 0;
  static double kopaytirish = 0;
  static double kopaytirishDop = 0;
  static double logika = 0;
  static double logikaDop = 0;

  // Lightning and streak tracking
  static DateTime? lastLightningDate;

  /// New: List of visit dates for streak tracking
  static List<DateTime> streakDates = [];

  /// Reset all fields to default
  static void reset() {
    matematikShtorm = 0;
    mathStormAttemptsLeft = 3;
    lastScore = 0;
    lastTime = 0;

    currentXP = 0;
    currentXP2 = 0;
    currentXP3 = 0;
    currentXP4 = 0;

    hearts = 5;
    lightnings = 0;
    gems = 0;

    score = 0;
    arifmetika = 0;
    arifmetikaDop = 0;
    kopaytirish = 0;
    kopaytirishDop = 0;
    logika = 0;
    logikaDop = 0;

    lastLightningDate = null;
    mathStormTimer = null;

    streakDates.clear();
  }

  /// Save all state to Firestore
  static Future<void> saveState(String userId) async {
    if (userId.isEmpty) return;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'activeFreezes': activeFreezes,
      'selectedLevel': selectedLevel,
      'firstName': firstName,
      'lastName': lastName,
      'matematikShtorm': matematikShtorm,
      'mathStormAttemptsLeft': mathStormAttemptsLeft,
      'lastScore': lastScore,
      'lastTime': lastTime,
      'currentXP': currentXP,
      'TcurrentXP': currentXP2,
      'hearts': hearts,
      'lightnings': lightnings,
      'gems': gems,
      'score': score,
      'arifmetika': arifmetika,
      'arifmetikaDop': arifmetikaDop,
      'kopaytirish': kopaytirish,
      'kopaytirishDop': kopaytirishDop,
      'logika': logika,
      'logikaDop': logikaDop,
      'lastLightningDate': lastLightningDate?.toIso8601String(),
      'mathStormTimer': mathStormTimer?.toIso8601String(),
      'streakDates': streakDates.map((d) => d.toIso8601String()).toList(),
    }, SetOptions(merge: true));
  }

  /// Load game state from Firestore
  static Future<void> loadState(String userId) async {
    if (userId.isEmpty) return;
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) return;

    final data = doc.data()!;

    activeFreezes = data['activeFreezes'] ?? 0;
    selectedLevel = data['selectedLevel'] ?? '';
    firstName = data['firstName'] ?? '';
    lastName = data['lastName'] ?? '';

    matematikShtorm = data['matematikShtorm'] ?? 0;
    mathStormAttemptsLeft = data['mathStormAttemptsLeft'] ?? 3;
    lastScore = data['lastScore'] ?? 0;
    lastTime = data['lastTime'] ?? 0;

    currentXP = (data['currentXP'] ?? 0).toDouble();
    currentXP2 = (data['TcurrentXP'] ?? 0).toDouble();
    hearts = data['hearts'] ?? 5;
    lightnings = data['lightnings'] ?? 0;
    gems = data['gems'] ?? 0;

    score = data['score'] ?? 0;
    arifmetika = (data['arifmetika'] ?? 0).toDouble();
    arifmetikaDop = (data['arifmetikaDop'] ?? 0).toDouble();
    kopaytirish = (data['kopaytirish'] ?? 0).toDouble();
    kopaytirishDop = (data['kopaytirishDop'] ?? 0).toDouble();
    logika = (data['logika'] ?? 0).toDouble();
    logikaDop = (data['logikaDop'] ?? 0).toDouble();

    lastLightningDate = _parseDate(data['lastLightningDate']);
    mathStormTimer = _parseDate(data['mathStormTimer']);

    // Parse streak dates
    if (data['streakDates'] != null && data['streakDates'] is List) {
      streakDates = (data['streakDates'] as List)
          .map((e) => DateTime.tryParse(e) ?? DateTime.now())
          .toList();
    }
  }

  /// Parse ISO8601 string to DateTime safely
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  /// Get current streak length by checking consecutive days
  static int getCurrentStreak() {
    DateTime today = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 7; i++) {
      DateTime checkDay = today.subtract(Duration(days: i));
      bool found = streakDates.any((d) =>
          d.year == checkDay.year &&
          d.month == checkDay.month &&
          d.day == checkDay.day);

      if (found) {
        streak++;
      } else {
        break; // streak breaks
      }
    }

    return streak;
  }

  /// Call this when user logs in today to update streak
  static void updateStreakForToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Already marked today? No action
    if (streakDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day)) {
      return;
    }

    // Check if yesterday was present
    DateTime yesterday = today.subtract(const Duration(days: 1));
    bool visitedYesterday = streakDates.any((d) =>
        d.year == yesterday.year && d.month == yesterday.month && d.day == yesterday.day);

    // If streak broken, reset
    if (!visitedYesterday && streakDates.isNotEmpty) {
      streakDates.clear();
    }

    // Add today
    streakDates.add(today);

    // Keep only last 7 days
    streakDates.removeWhere((d) => today.difference(d).inDays > 6);

    // Update lightning
    lightnings++;
    lastLightningDate = now;
  }
}
