import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('This config is only set up for web.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyA9gKTdOnRiAbwJzbt1xOXin5GnTYk5kjQ",
    authDomain: "alochiauth-fa3ee.firebaseapp.com",
    projectId: "alochiauth-fa3ee",
    storageBucket: "alochiauth-fa3ee.firebasestorage.app",
    messagingSenderId: "481207852696",
    appId: "1:481207852696:web:2f76003f12bf525e3ebaed",
    measurementId: "G-Z7H40XM25V"
  );
}
