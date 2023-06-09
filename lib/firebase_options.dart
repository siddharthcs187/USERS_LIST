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
    apiKey: 'AIzaSyBZukjsfHFH12yF_m0IHsybM5pcKmm9agE',
    appId: '1:916089365017:web:a5d3f798b84251bd820088',
    messagingSenderId: '916089365017',
    projectId: 'users-list-607c1',
    authDomain: 'users-list-607c1.firebaseapp.com',
    storageBucket: 'users-list-607c1.appspot.com',
    measurementId: 'G-T3D54DQYPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDT-7eh5S8r7Vy7DObk9JVRxLch3B5rDss',
    appId: '1:916089365017:android:4c9187d30c405f17820088',
    messagingSenderId: '916089365017',
    projectId: 'users-list-607c1',
    storageBucket: 'users-list-607c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTQXRbQlA2B_Fg6SYLrYtSew-glCVhco0',
    appId: '1:916089365017:ios:0d4c3c15ade6bba8820088',
    messagingSenderId: '916089365017',
    projectId: 'users-list-607c1',
    storageBucket: 'users-list-607c1.appspot.com',
    iosClientId: '916089365017-caobiekllr08bjg83m4nctfn85evqad4.apps.googleusercontent.com',
    iosBundleId: 'com.example.usersList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTQXRbQlA2B_Fg6SYLrYtSew-glCVhco0',
    appId: '1:916089365017:ios:ea244f6dfa94134b820088',
    messagingSenderId: '916089365017',
    projectId: 'users-list-607c1',
    storageBucket: 'users-list-607c1.appspot.com',
    iosClientId: '916089365017-0vkv4mjo38l8a79cumtddlc7mk1efqha.apps.googleusercontent.com',
    iosBundleId: 'com.example.usersList.RunnerTests',
  );
}
