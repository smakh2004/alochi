// ------------------------------------ //
//  Creator and Founder of A'lochi App  //
//      MAKHAMMATOV SIROJIDDIN          //
// ------------------------------------ //

import 'package:alochi_math_app/SplashScreenPage.dart';
import 'package:alochi_math_app/firebase_options.dart';
import 'package:alochi_math_app/generated/l10n.dart';
import 'package:alochi_math_app/pages/Connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Add Provider import
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Prevent duplicate initialization
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      Firebase.app(); // just use existing app
    }
  } catch (e) {
    //Log error only once
    debugPrint('Firebase already initialized: $e');
  }

  runApp(
    // Wrap the app with ChangeNotifierProvider to provide connectivity status globally
    ChangeNotifierProvider(
      create: (_) => ConnectivityService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // Allows changing the app language from anywhere
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('uz'); // Default language: Uzbek

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreenPage(),
    );
  }
}
