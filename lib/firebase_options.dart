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
    apiKey: 'AIzaSyBAiFPuf9n7o_PztO7A6Q7eRfmHlMtbbRE',
    appId: '1:161508747965:web:abda1c815828b29a5265d4',
    messagingSenderId: '161508747965',
    projectId: 'letmebeyourchef-efbaa',
    authDomain: 'letmebeyourchef-efbaa.firebaseapp.com',
    databaseURL: 'https://letmebeyourchef-efbaa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'letmebeyourchef-efbaa.appspot.com',
    measurementId: 'G-Z14J81W702',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6gyyrFziUrhowG-6deokCg4nCcA2dXIM',
    appId: '1:161508747965:android:2ee9e45c5359398e5265d4',
    messagingSenderId: '161508747965',
    projectId: 'letmebeyourchef-efbaa',
    databaseURL: 'https://letmebeyourchef-efbaa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'letmebeyourchef-efbaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjjmq7qTdzrBGWHslAKTXG5VXpDySrgE4',
    appId: '1:161508747965:ios:af127f56560ff5a65265d4',
    messagingSenderId: '161508747965',
    projectId: 'letmebeyourchef-efbaa',
    databaseURL: 'https://letmebeyourchef-efbaa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'letmebeyourchef-efbaa.appspot.com',
    androidClientId: '161508747965-um4gbin56kq8rrgb8jhpva1nm83vpop1.apps.googleusercontent.com',
    iosClientId: '161508747965-3m8qch7d6svkg6gd2abbmt1vf8v9pjq9.apps.googleusercontent.com',
    iosBundleId: 'com.example.letmebeyourchefflutter.letmebeyourchefflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjjmq7qTdzrBGWHslAKTXG5VXpDySrgE4',
    appId: '1:161508747965:ios:c896380cbe0cf77b5265d4',
    messagingSenderId: '161508747965',
    projectId: 'letmebeyourchef-efbaa',
    databaseURL: 'https://letmebeyourchef-efbaa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'letmebeyourchef-efbaa.appspot.com',
    androidClientId: '161508747965-um4gbin56kq8rrgb8jhpva1nm83vpop1.apps.googleusercontent.com',
    iosClientId: '161508747965-g7bn1i686hqngr8c4pohtm715bdrl8kr.apps.googleusercontent.com',
    iosBundleId: 'com.example.letmebeyourchefflutter.letmebeyourchefflutter.RunnerTests',
  );
}