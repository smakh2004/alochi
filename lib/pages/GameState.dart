// ignore_for_file: file_names, non_constant_identifier_names


class GameState {
  static int matematikShtorm = 0;
  static int mathStormAttemptsLeft = 3;

  static int lastScore = 0;
  static int lastTime = 0;

  static double currentXP = 0;
  static double maxXP = 100;

  static double TcurrentXP = 0;
  static double TmaxXP = 100;

  static int hearts = 5;
  static int lightnings = 0;
  static int gems = 0;

  static int score = 0;
  static int scoreDop = 0;

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

  // // UNCOMMENT FOR SHARED PREFERENCES AND SAVING VALUES AFTER REENTERING TO THE APP
  // /// Load all values from SharedPreferences
  // static Future<void> loadState() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   matematikShtorm = prefs.getInt('matematikShtorm') ?? 0;
  //   mathStormAttemptsLeft = prefs.getInt('mathStormAttemptsLeft') ?? 3;

  //   lastScore = prefs.getInt('lastScore') ?? 0;
  //   lastTime = prefs.getInt('lastTime') ?? 0;

  //   currentXP = prefs.getDouble('currentXP') ?? 0;
  //   maxXP = prefs.getDouble('maxXP') ?? 100;

  //   TcurrentXP = prefs.getDouble('TcurrentXP') ?? 0;
  //   TmaxXP = prefs.getDouble('TmaxXP') ?? 100;

  //   hearts = prefs.getInt('hearts') ?? 5;
  //   lightnings = prefs.getInt('lightnings') ?? 0;
  //   gems = prefs.getInt('gems') ?? 0;

  //   score = prefs.getInt('score') ?? 0;
  //   scoreDop = prefs.getInt('scoreDop') ?? 0;

  //   arifmetika = prefs.getDouble('arifmetika') ?? 0;
  //   arifmetikaMax = prefs.getDouble('arifmetikaMax') ?? 100;
  //   arifmetikaDop = prefs.getDouble('arifmetikaDop') ?? 0;

  //   kopaytirish = prefs.getDouble('kopaytirish') ?? 0;
  //   kopaytirishMax = prefs.getDouble('kopaytirishMax') ?? 100;
  //   kopaytirishDop = prefs.getDouble('kopaytirishDop') ?? 0;

  //   logika = prefs.getDouble('logika') ?? 0;
  //   logikaMax = prefs.getDouble('logikaMax') ?? 100;
  //   logikaDop = prefs.getDouble('logikaDop') ?? 0;

  //   lastLightningDate = _loadDate(prefs, 'lastLightningDate');
  //   lastLightningDate1 = _loadDate(prefs, 'lastLightningDate1');
  // }

  // /// Save all values to SharedPreferences
  // static Future<void> saveState() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   await prefs.setInt('matematikShtorm', matematikShtorm);
  //   await prefs.setInt('mathStormAttemptsLeft', mathStormAttemptsLeft);

  //   await prefs.setInt('lastScore', lastScore);
  //   await prefs.setInt('lastTime', lastTime);

  //   await prefs.setDouble('currentXP', currentXP);
  //   await prefs.setDouble('maxXP', maxXP);

  //   await prefs.setDouble('TcurrentXP', TcurrentXP);
  //   await prefs.setDouble('TmaxXP', TmaxXP);

  //   await prefs.setInt('hearts', hearts);
  //   await prefs.setInt('lightnings', lightnings);
  //   await prefs.setInt('gems', gems);

  //   await prefs.setInt('score', score);
  //   await prefs.setInt('scoreDop', scoreDop);

  //   await prefs.setDouble('arifmetika', arifmetika);
  //   await prefs.setDouble('arifmetikaMax', arifmetikaMax);
  //   await prefs.setDouble('arifmetikaDop', arifmetikaDop);

  //   await prefs.setDouble('kopaytirish', kopaytirish);
  //   await prefs.setDouble('kopaytirishMax', kopaytirishMax);
  //   await prefs.setDouble('kopaytirishDop', kopaytirishDop);

  //   await prefs.setDouble('logika', logika);
  //   await prefs.setDouble('logikaMax', logikaMax);
  //   await prefs.setDouble('logikaDop', logikaDop);

  //   await _saveDate(prefs, 'lastLightningDate', lastLightningDate);
  //   await _saveDate(prefs, 'lastLightningDate1', lastLightningDate1);
  // }

  // /// Helper to save DateTime
  // static Future<void> _saveDate(SharedPreferences prefs, String key, DateTime? date) async {
  //   if (date != null) {
  //     await prefs.setString(key, date.toIso8601String());
  //   }
  // }

  // /// Helper to load DateTime
  // static DateTime? _loadDate(SharedPreferences prefs, String key) {
  //   final dateString = prefs.getString(key);
  //   return dateString != null ? DateTime.tryParse(dateString) : null;
  // }
}