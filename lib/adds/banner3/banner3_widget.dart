import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'banner3_model.dart';
export 'banner3_model.dart';

class Banner3Widget extends StatefulWidget {
  const Banner3Widget({super.key});

  @override
  State<Banner3Widget> createState() => _Banner3WidgetState();
}

class _Banner3WidgetState extends State<Banner3Widget> {
  late Banner3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Banner3Model());

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
        androidAdUnitID: 'ca-app-pub-1155465785334479/7221190132',
      ),
    );
  }
}
