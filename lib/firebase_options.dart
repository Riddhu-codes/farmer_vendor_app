import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web not configured.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'Windows not configured.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'iOS not configured.',
        );
      default:
        throw UnsupportedError(
          'Platform not supported.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    appId: "YOUR_APP_ID",
    messagingSenderId: "YOUR_SENDER_ID",
    projectId: "farmer-vrndor-app",
    storageBucket: "farmer-vrndor-app.appspot.com",
  );
}