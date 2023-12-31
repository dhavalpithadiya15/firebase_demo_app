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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxqzbiXMYSXmVujyV6kCPpoT3hP2IsCpk',
    appId: '1:359226022906:android:cd6dd402220f5a74cc6243',
    messagingSenderId: '359226022906',
    projectId: 'fir-demo-app-5285e',
    storageBucket: 'fir-demo-app-5285e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIVFuGDOYJYcdaHBlTdRcocaJ6Xs244qw',
    appId: '1:359226022906:ios:c758576eed788437cc6243',
    messagingSenderId: '359226022906',
    projectId: 'fir-demo-app-5285e',
    storageBucket: 'fir-demo-app-5285e.appspot.com',
    androidClientId: '359226022906-pnbrs9jnip4sa5hk54u094khb90vtmgh.apps.googleusercontent.com',
    iosClientId: '359226022906-im9movs2p60ibbrtofp0gmugtn73phjr.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseDemoApp',
  );
}
