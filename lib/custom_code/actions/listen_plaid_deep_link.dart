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

Future<String> listenPlaidDeepLink() async {
  try {
    final uri = Uri.base;

    if (uri.path.contains('plaid-success')) {
      return uri.queryParameters['itemId'] ?? '';
    }

    return '';
  } catch (e) {
    return '';
  }
}
