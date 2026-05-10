// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import '/auth/firebase_auth/auth_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

Future<bool> saveFcmTokenToFirestore() async {
  try {
    final uid = currentUserUid;

    if (uid.isEmpty) {
      print('[FCM] ❌ No authenticated user');
      return false;
    }

    final settings = await FirebaseMessaging.instance.getNotificationSettings();

    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      print('[FCM] ❌ Notification permission not granted');
      return false;
    }

    if (Platform.isIOS) {
      String? apnsToken;

      for (int i = 0; i < 10; i++) {
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();

        if (apnsToken != null && apnsToken.isNotEmpty) {
          print('[FCM] ✅ APNs token ready');
          break;
        }

        print('[FCM] ⏳ Waiting for APNs token... attempt ${i + 1}');
        await Future.delayed(const Duration(seconds: 1));
      }

      if (apnsToken == null || apnsToken.isEmpty) {
        print('[FCM] ❌ APNs token is null or empty');
        return false;
      }
    }

    String? token;

    for (int i = 0; i < 10; i++) {
      token = await FirebaseMessaging.instance.getToken();

      if (token != null && token.isNotEmpty) {
        print('[FCM] ✅ FCM token ready');
        break;
      }

      print('[FCM] ⏳ Waiting for FCM token... attempt ${i + 1}');
      await Future.delayed(const Duration(seconds: 1));
    }

    if (token == null || token.isEmpty) {
      print('[FCM] ❌ FCM token is null or empty');
      return false;
    }

    final deviceType = Platform.isIOS
        ? 'iOS'
        : Platform.isAndroid
            ? 'Android'
            : 'Other';

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('fcm_tokens')
        .doc(token)
        .set({
      'fcm_token': token,
      'device_type': deviceType,
      'updated_at': FieldValue.serverTimestamp(),
      'created_at': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    print('[FCM] ✅ Token saved/updated successfully');
    return true;
  } catch (e) {
    print('[FCM] ❌ Error saving token: $e');
    return false;
  }
}
