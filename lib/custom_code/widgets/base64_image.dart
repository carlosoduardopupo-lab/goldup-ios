// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

class Base64Image extends StatelessWidget {
  const Base64Image({
    Key? key,
    this.width,
    this.height,
    this.base64String,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? base64String; // ✅ Nullable — ya no es required

  @override
  Widget build(BuildContext context) {
    if (base64String == null || base64String!.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    try {
      String cleaned = base64String!;
      if (cleaned.contains(',')) {
        cleaned = cleaned.split(',').last;
      }
      cleaned = cleaned.replaceAll('\n', '').replaceAll('\r', '');

      return Image.memory(
        base64Decode(cleaned),
        width: width,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            SizedBox(width: width, height: height),
      );
    } catch (e) {
      return SizedBox(width: width, height: height);
    }
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
