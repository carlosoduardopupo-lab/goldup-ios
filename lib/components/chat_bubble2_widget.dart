import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_bubble2_model.dart';
export 'chat_bubble2_model.dart';

class ChatBubble2Widget extends StatefulWidget {
  const ChatBubble2Widget({
    super.key,
    bool? isAi,
    String? content,
    String? time,
    bool? isSuggestion,
  })  : this.isAi = isAi ?? true,
        this.content = content ??
            '¡Hola Alex! He revisado tus gastos de ayer. Gastaste \$45 en restaurantes, lo cual es un 10% más de tu promedio diario.',
        this.time = time ?? '09:41 AM',
        this.isSuggestion = isSuggestion ?? false;

  final bool isAi;
  final String content;
  final String time;
  final bool isSuggestion;

  @override
  State<ChatBubble2Widget> createState() => _ChatBubble2WidgetState();
}

class _ChatBubble2WidgetState extends State<ChatBubble2Widget> {
  late ChatBubble2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatBubble2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                () {
                  if ((widget!.isAi == true) &&
                      (widget!.isSuggestion == true)) {
                    return Color(0x331B4332);
                  } else if ((widget!.isAi == true) &&
                      (widget!.isSuggestion == false)) {
                    return Color(0x00000000);
                  } else {
                    return Color(0xFC073431);
                  }
                }(),
                Color(0x33C9A84C),
              ),
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: widget!.isSuggestion == true
                    ? Color(0xFFE5C158)
                    : Colors.transparent,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.content,
                  'Content',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.roboto(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: widget!.isSuggestion == true
                          ? Color(0xFFE5C158)
                          : FlutterFlowTheme.of(context).alternate,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ),
          ),
          if (widget!.isSuggestion == false)
            Text(
              widget!.time,
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    font: GoogleFonts.roboto(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
        ].divide(SizedBox(height: 4.0)),
      ),
    );
  }
}
