import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class IFonts {
  TextStyle get openSansRegular;
  TextStyle get openSansBold;
  TextStyle get quicksandLight;
  TextStyle get quicksandMedium;
  TextStyle get quicksandBold;
}

class Fonts implements IFonts {
  @override
  TextStyle get openSansRegular =>
      GoogleFonts.openSans(fontWeight: FontWeight.normal);

  @override
  TextStyle get openSansBold =>
      GoogleFonts.openSans(fontWeight: FontWeight.bold);

  @override
  TextStyle get quicksandLight =>
      GoogleFonts.quicksand(fontWeight: FontWeight.w200);

  @override
  TextStyle get quicksandMedium =>
      GoogleFonts.quicksand(fontWeight: FontWeight.normal);

  @override
  TextStyle get quicksandBold => GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black,
      );
}
