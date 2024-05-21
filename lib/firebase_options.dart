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

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4Nf93KPJE3N9Rokke4d5bzQrzFgFOaAs',
    appId: '1:509301025795:web:7319ee7564b2127d423236',
    messagingSenderId: '509301025795',
    projectId: 'chatappproject-37001',
    authDomain: 'chatappproject-37001.firebaseapp.com',
    storageBucket: 'chatappproject-37001.appspot.com',
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwUjY1QCso7UawAjnSoj7eVgLe-MW7edM',
    appId: '1:509301025795:android:854292d3fec0e015423236',
    messagingSenderId: '509301025795',
    projectId: 'chatappproject-37001',
    storageBucket: 'chatappproject-37001.appspot.com',
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwaad2yi6AD933h_RHOKCTfSAkhWV64LM',
    appId: '1:509301025795:ios:c261276b9f0573a9423236',
    messagingSenderId: '509301025795',
    projectId: 'chatappproject-37001',
    storageBucket: 'chatappproject-37001.appspot.com',
    iosBundleId: 'com.example.flutterChapappFirebase',
  );

  static final FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwaad2yi6AD933h_RHOKCTfSAkhWV64LM',
    appId: '1:509301025795:ios:c261276b9f0573a9423236',
    messagingSenderId: '509301025795',
    projectId: 'chatappproject-37001',
    storageBucket: 'chatappproject-37001.appspot.com',
    iosBundleId: 'com.example.flutterChapappFirebase',
  );

  static final FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4Nf93KPJE3N9Rokke4d5bzQrzFgFOaAs',
    appId: '1:509301025795:web:02b2f58a547d8254423236',
    messagingSenderId: '509301025795',
    projectId: 'chatappproject-37001',
    authDomain: 'chatappproject-37001.firebaseapp.com',
    storageBucket: 'chatappproject-37001.appspot.com',
  );
}
