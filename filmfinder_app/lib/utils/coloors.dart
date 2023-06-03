import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Coolors {
  static const kAppBarBackgroundColor = Color(0xFFFFFFFF);
  static const kBackgroundColor = Color(0xFFF2F2F6);
  static const kLightBlue = Color(0xFF61C3F2);
  static const kNavBarColor = Color(0xFF2E2739);
  static const kNavBarIconColor = Color(0xff827D88);
  // For generes tags
  static const kGenereGreenColor = Color(0xff15D2BC);
  static const kGenerePinkColor = Color(0xffE26CA5);
  static const kGenerepurpleColor = Color(0xff564CA3);
  static const kGenereYellowColor = Color(0xffCD9D0F);

  static final filmFinderTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kLightBlue),
    scaffoldBackgroundColor: kBackgroundColor,
    useMaterial3: true,
  );
}

// It will define all the colors and themes used in the app