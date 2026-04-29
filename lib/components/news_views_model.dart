import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'news_views_widget.dart' show NewsViewsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsViewsModel extends FlutterFlowModel<NewsViewsWidget> {
  ///  Local state fields for this component.

  String? image;

  String? title;

  String? description;

  String? sourse;

  String? sourceUrl;

  DocumentReference? newRef;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in newsViews widget.
  NewsRecord? newDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
