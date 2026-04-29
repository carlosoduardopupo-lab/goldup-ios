import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBihhVnbw4SZcfndU5z03VJvN26iAUXmzw",
            authDomain: "calendar-ten2s9.firebaseapp.com",
            projectId: "calendar-ten2s9",
            storageBucket: "calendar-ten2s9.firebasestorage.app",
            messagingSenderId: "351723314046",
            appId: "1:351723314046:web:71e77ad9c9c163bc5eb12f",
            measurementId: "G-TJ1Q7HSXJ5"));
  } else {
    await Firebase.initializeApp();
  }
}
