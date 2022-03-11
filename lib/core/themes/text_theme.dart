import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
).apply(
  displayColor: Colors.black,
  bodyColor: Colors.black,
);
