import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/backend/schema/structs/index.dart';
import '/components/chat_bubble2_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'chat_i_a_widget.dart' show ChatIAWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatIAModel extends FlutterFlowModel<ChatIAWidget> {
  ///  Local state fields for this page.

  bool isLoading = false;

  bool chatIsStarted = false;

  String? text;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Cloud Function - goldAdvisorWelcomeV2] action in ChatIA widget.
  GoldAdvisorWelcomeV2CloudFunctionCallResponse? cloudFunctionn2p;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<ChatsIARecord>? chat;
  // Models for ChatBubble.
  late FlutterFlowDynamicModels<ChatBubble2Model> chatBubbleModels;
  // Stores action output result for [Cloud Function - askGoldAdvisorV2] action in ChatBubble widget.
  AskGoldAdvisorV2CloudFunctionCallResponse? cloudFunctionlek3;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Cloud Function - askGoldAdvisorV2] action in IconButton widget.
  AskGoldAdvisorV2CloudFunctionCallResponse? cloudFunctionlek4;

  @override
  void initState(BuildContext context) {
    chatBubbleModels = FlutterFlowDynamicModels(() => ChatBubble2Model());
  }

  @override
  void dispose() {
    chatBubbleModels.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
