from pathlib import Path

# =========================
# PATCH FLUTTERFLOW FONTS
# =========================

theme_file = Path("lib/flutter_flow/flutter_flow_theme.dart")

if theme_file.exists():
    s = theme_file.read_text(encoding="utf-8")

    helper = """
TextStyle safeRoboto({
  Color? color,
  FontWeight? fontWeight,
  double? fontSize,
  double? letterSpacing,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  List<Shadow>? shadows,
}) {
  return TextStyle(
    fontFamily: 'Roboto',
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    height: height,
    shadows: shadows,
  );
}
"""

    if "TextStyle safeRoboto({" not in s:
        s = s.replace(
            "abstract class FlutterFlowTheme {",
            helper + "\nabstract class FlutterFlowTheme {"
        )

    s = s.replace("GoogleFonts.roboto(", "safeRoboto(")

    old_block = """if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }"""

    new_block = """if (useGoogleFonts && fontFamily != null) {
      try {
        font = GoogleFonts.getFont(
          fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle,
        );
      } catch (_) {
        font = TextStyle(
          fontFamily: fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle,
        );
      }
    }"""

    s = s.replace(old_block, new_block)

    theme_file.write_text(s, encoding="utf-8")

    print("FlutterFlow font patch applied.")

else:
    print("flutter_flow_theme.dart not found, skipping font patch.")


# =========================
# ENSURE CODEMAGIC FILE
# =========================

template = Path(".github/templates/codemagic.yaml")
target = Path("codemagic.yaml")

if template.exists():
    if not target.exists():
        target.write_text(
            template.read_text(encoding="utf-8"),
            encoding="utf-8"
        )
        print("codemagic.yaml created from template.")
    else:
        print("codemagic.yaml already exists.")
else:
    print("codemagic template not found.")
