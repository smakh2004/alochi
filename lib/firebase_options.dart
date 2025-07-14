import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA9gKTdOnRiAbwJzbt1xOXin5GnTYk5kjQ',
    authDomain: 'alochiauth-fa3ee.firebaseapp.com',
    projectId: 'alochiauth-fa3ee',
    storageBucket: 'alochiauth-fa3ee.appspot.com', // ✅ fixed
    messagingSenderId: '481207852696',
    appId: '1:481207852696:web:2f76003f12bf525e3ebaed',
    measurementId: 'G-Z7H40XM25V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9gKTdOnRiAbwJzbt1xOXin5GnTYk5kjQ',
    appId: '1:481207852696:web:2f76003f12bf525e3ebaed',
    messagingSenderId: '481207852696',
    projectId: 'alochiauth-fa3ee',
    storageBucket: 'alochiauth-fa3ee.appspot.com', // ✅ fixed
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9gKTdOnRiAbwJzbt1xOXin5GnTYk5kjQ',
    appId: '1:481207852696:web:2f76003f12bf525e3ebaed',
    messagingSenderId: '481207852696',
    projectId: 'alochiauth-fa3ee',
    storageBucket: 'alochiauth-fa3ee.appspot.com', // ✅ fixed
    iosBundleId: 'com.yourcompany.alochiMathApp', // Replace with your actual iOS bundle ID
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9gKTdOnRiAbwJzbt1xOXin5GnTYk5kjQ',
    appId: '1:481207852696:web:2f76003f12bf525e3ebaed',
    messagingSenderId: '481207852696',
    projectId: 'alochiauth-fa3ee',
    storageBucket: 'alochiauth-fa3ee.appspot.com', // ✅ fixed
  );
}
