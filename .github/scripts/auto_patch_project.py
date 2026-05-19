from pathlib import Path
import shutil

# =========================
# PATCH PUBSPEC DEPENDENCIES
# =========================

pubspec = Path("pubspec.yaml")

if pubspec.exists():
    s = pubspec.read_text(encoding="utf-8")

    # Mantener versiones fijas compatibles con FlutterFlow generado
    s = s.replace("font_awesome_flutter: ^10.6.0", "font_awesome_flutter: 10.6.0")
    s = s.replace("font_awesome_flutter: 10.7.0", "font_awesome_flutter: 10.6.0")
    s = s.replace("font_awesome_flutter: ^10.7.0", "font_awesome_flutter: 10.6.0")
    s = s.replace("font_awesome_flutter: ^10.10.0", "font_awesome_flutter: 10.6.0")
    s = s.replace("font_awesome_flutter: ^10.12.0", "font_awesome_flutter: 10.6.0")
    s = s.replace("font_awesome_flutter: ^11.0.0", "font_awesome_flutter: 10.6.0")

    # FlutterFlow usa page_transition internamente, NO eliminar
    s = s.replace("page_transition: ^2.1.0", "page_transition: 2.1.0")
    s = s.replace("page_transition: 2.2.1", "page_transition: 2.1.0")
    s = s.replace("page_transition: ^2.2.1", "page_transition: 2.1.0")

    pubspec.write_text(s, encoding="utf-8")
    print("pubspec.yaml dependencies patched.")
else:
    print("pubspec.yaml not found.")

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


# =========================
# REMOVE IMAGENOTIFICATION
# =========================

image_notification = Path("ios/ImageNotification")

if image_notification.exists():
    shutil.rmtree(image_notification)
    print("ios/ImageNotification removed.")
else:
    print("ios/ImageNotification not found.")


# =========================
# RESTORE PODFILE
# =========================

pod_template = Path(".github/templates/Podfile")
pod_target = Path("ios/Podfile")

if pod_template.exists():
    pod_target.parent.mkdir(parents=True, exist_ok=True)
    pod_target.write_text(
        pod_template.read_text(encoding="utf-8"),
        encoding="utf-8"
    )
    print("ios/Podfile restored from template.")
else:
    print("Podfile template not found.")


# =========================
# RESTORE XCODE PROJECT
# =========================

pbx_template = Path(".github/templates/project.pbxproj")
pbx_target = Path("ios/Runner.xcodeproj/project.pbxproj")

if pbx_template.exists():
    pbx_target.parent.mkdir(parents=True, exist_ok=True)
    pbx_target.write_text(
        pbx_template.read_text(encoding="utf-8"),
        encoding="utf-8"
    )
    print("ios/Runner.xcodeproj/project.pbxproj restored from template.")
else:
    print("project.pbxproj template not found.")


# =========================
# RESTORE ASSETS ROOT CONTENTS
# =========================

assets_contents_template = Path(".github/templates/Assets.xcassets/Contents.json")
assets_contents_target = Path("ios/Runner/Assets.xcassets/Contents.json")

if assets_contents_template.exists():
    assets_contents_target.parent.mkdir(parents=True, exist_ok=True)

    assets_contents_target.write_text(
        assets_contents_template.read_text(encoding="utf-8"),
        encoding="utf-8"
    )

    print("Assets.xcassets/Contents.json restored.")
else:
    print("Assets.xcassets Contents template not found.")


# =========================
# RESTORE APP ICON FILES ONLY
# =========================

appicon_template = Path(".github/templates/Assets.xcassets/AppIcon.appiconset")
appicon_target = Path("ios/Runner/Assets.xcassets/AppIcon.appiconset")

if appicon_template.exists():
    appicon_target.mkdir(parents=True, exist_ok=True)

    for item in appicon_target.iterdir():
        if item.is_file():
            item.unlink()

    for item in appicon_template.iterdir():
        if item.is_file():
            shutil.copy2(item, appicon_target / item.name)

    print("AppIcon.appiconset files restored from template.")
else:
    print("AppIcon.appiconset template not found.")


# =========================
# REMOVE LAUNCHIMAGE
# =========================

launch_image = Path("ios/Runner/Assets.xcassets/LaunchImage.imageset")

if launch_image.exists():
    shutil.rmtree(launch_image)
    print("LaunchImage.imageset removed.")
else:
    print("LaunchImage.imageset not found.")
