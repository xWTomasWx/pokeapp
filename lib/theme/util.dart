import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme _googleFontTextTheme(String fontFamily, TextTheme baseTextTheme) {
  switch (fontFamily) {
    case 'Press Start 2P':
      return GoogleFonts.pressStart2pTextTheme(baseTextTheme);
    default:
      return GoogleFonts.getTextTheme(fontFamily, baseTextTheme);
  }
}

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = _googleFontTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      _googleFontTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
