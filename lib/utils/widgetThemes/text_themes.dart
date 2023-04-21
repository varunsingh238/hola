import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextTheme {
  static TextTheme lightTextTheme = TextTheme(
      displayMedium: GoogleFonts.montserrat(
          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 35),
      titleSmall: GoogleFonts.poppins(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w300),
      titleMedium: GoogleFonts.poppins(
          color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.poppins(
          color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold));

  static TextTheme darkTextTheme = TextTheme(
      displayMedium: GoogleFonts.montserrat(
          color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 35),
      titleSmall: GoogleFonts.poppins(
          color: Colors.white60, fontSize: 20, fontWeight: FontWeight.w300),
      titleMedium: GoogleFonts.poppins(
          color: Colors.white60, fontSize: 15, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.poppins(
          color: Colors.white60, fontSize: 18, fontWeight: FontWeight.bold));
}
