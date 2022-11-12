// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBgBRxZ6cd6jGwDZVyswcvOa7j2n2fcDgo',
    appId: '1:1051664949216:web:332aca136388b1c58e5585',
    messagingSenderId: '1051664949216',
    projectId: 'fire-test-cd0e5',
    authDomain: 'fire-test-cd0e5.firebaseapp.com',
    storageBucket: 'fire-test-cd0e5.appspot.com',
    measurementId: 'G-FZV2MYMQKE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX9jgvyQ6RKXGTbGu-tf2Srzq-jrvxZAg',
    appId: '1:1051664949216:android:bb83c5def248b4ed8e5585',
    messagingSenderId: '1051664949216',
    projectId: 'fire-test-cd0e5',
    storageBucket: 'fire-test-cd0e5.appspot.com',
  );
}