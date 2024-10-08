// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBP694PH2O6mND5LuUIguaSAOuITTYElk8',
    appId: '1:609385997302:web:317e63523be3e8779f5dd7',
    messagingSenderId: '609385997302',
    projectId: 'fir-crud-730ba',
    authDomain: 'fir-crud-730ba.firebaseapp.com',
    storageBucket: 'fir-crud-730ba.appspot.com',
    measurementId: 'G-EFCY5L4C4X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDqaM-3ZeZGgzA1k5ra4BD8Fhf1rU_Ms8',
    appId: '1:609385997302:android:fafb3458d2650e4f9f5dd7',
    messagingSenderId: '609385997302',
    projectId: 'fir-crud-730ba',
    storageBucket: 'fir-crud-730ba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4rtRmGomV8yu1F47foWSILLsStSqURPo',
    appId: '1:609385997302:ios:3a2ca35fd1aeae109f5dd7',
    messagingSenderId: '609385997302',
    projectId: 'fir-crud-730ba',
    storageBucket: 'fir-crud-730ba.appspot.com',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4rtRmGomV8yu1F47foWSILLsStSqURPo',
    appId: '1:609385997302:ios:3a2ca35fd1aeae109f5dd7',
    messagingSenderId: '609385997302',
    projectId: 'fir-crud-730ba',
    storageBucket: 'fir-crud-730ba.appspot.com',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBP694PH2O6mND5LuUIguaSAOuITTYElk8',
    appId: '1:609385997302:web:68d1a52a73da5bb49f5dd7',
    messagingSenderId: '609385997302',
    projectId: 'fir-crud-730ba',
    authDomain: 'fir-crud-730ba.firebaseapp.com',
    storageBucket: 'fir-crud-730ba.appspot.com',
    measurementId: 'G-XK8V213QQT',
  );
}
