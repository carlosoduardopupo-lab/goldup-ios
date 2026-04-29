import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'banner4_model.dart';
export 'banner4_model.dart';

class Banner4Widget extends StatefulWidget {
  const Banner4Widget({super.key});

  @override
  State<Banner4Widget> createState() => _Banner4WidgetState();
}

class _Banner4WidgetState extends State<Banner4Widget> {
  late Banner4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Banner4Model());

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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: FlutterFlowAdBanner(
        width: MediaQuery.sizeOf(context).width * 3.7,
        height: 115.0,
        showsTestAd: false,
        androidAdUnitID: 'ca-app-pub-1155465785334479/6117029436',
      ),
    );
  }
}
