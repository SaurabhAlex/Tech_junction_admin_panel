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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDPmUvPYBaW4rRq8XxZoKKq4-jSiKdLgTM',
    appId: '1:700152334074:web:2f09747c08f1f20d396b43',
    messagingSenderId: '700152334074',
    projectId: 'gadget-world-3cf48',
    authDomain: 'gadget-world-3cf48.firebaseapp.com',
    storageBucket: 'gadget-world-3cf48.appspot.com',
    measurementId: 'G-Q4CPXTHLR4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmiqelOzh9tWSewucIfH38N8AgJVTwcag',
    appId: '1:700152334074:android:5b149cfc0ba8176e396b43',
    messagingSenderId: '700152334074',
    projectId: 'gadget-world-3cf48',
    storageBucket: 'gadget-world-3cf48.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6H41n4wSRrzsvvJv0pskZ1w2Q6rVapFk',
    appId: '1:700152334074:ios:dc38ba483661959f396b43',
    messagingSenderId: '700152334074',
    projectId: 'gadget-world-3cf48',
    storageBucket: 'gadget-world-3cf48.appspot.com',
    iosClientId: '700152334074-8jm84t6dncet1nklvt3nddd21f8q64m4.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminTech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6H41n4wSRrzsvvJv0pskZ1w2Q6rVapFk',
    appId: '1:700152334074:ios:84e75d1dcc7e5552396b43',
    messagingSenderId: '700152334074',
    projectId: 'gadget-world-3cf48',
    storageBucket: 'gadget-world-3cf48.appspot.com',
    iosClientId: '700152334074-cpjfo4mb756mf0omhfr2o54o95gt7c70.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminTech.RunnerTests',
  );
}
