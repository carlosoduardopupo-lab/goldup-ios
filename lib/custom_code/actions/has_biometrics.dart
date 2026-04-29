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

import 'package:local_auth/local_auth.dart';

Future<bool> hasBiometrics() async {
  final LocalAuthentication auth = LocalAuthentication();

  try {
    final bool isSupported = await auth.isDeviceSupported();
    final bool canCheckBiometrics = await auth.canCheckBiometrics;

    return isSupported && canCheckBiometrics;
  } catch (e) {
    return false;
  }
}
