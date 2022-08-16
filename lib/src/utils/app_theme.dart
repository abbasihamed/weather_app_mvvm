import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      primaryColor: Colors.yellow,
      textTheme: TextTheme(
        headline1: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: GoogleFonts.alumniSans(
          color: Colors.white,
          fontSize: 28,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
