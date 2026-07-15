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

class TypewriterText extends StatefulWidget {
  const TypewriterText({
    super.key,
    this.width,
    this.height,
    this.text,
    this.speed,
  });

  final double? width;
  final double? height;
  final String? text;
  final int? speed;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayed = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _type();
  }

  @override
  void didUpdateWidget(TypewriterText old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text) {
      setState(() {
        _displayed = '';
        _index = 0;
      });
      _type();
    }
  }

  void _type() {
    final text = widget.text ?? '';
    final ms = widget.speed ?? 25;
    if (_index < text.length) {
      Future.delayed(Duration(milliseconds: ms), () {
        if (!mounted) return;
        setState(() {
          _index++;
          _displayed = text.substring(0, _index);
        });
        _type();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayed,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
