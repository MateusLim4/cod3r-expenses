import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class IFonts {
  TextStyle get openSansRegular;
  TextStyle get openSansBold;
  TextStyle get quicksandLight;
  TextStyle get quicksandMedium;
  TextStyle get quicksandBold;
  TextStyle get priceTitle;
}

class Fonts implements IFonts {
  @override
  TextStyle get priceTitle => GoogleFonts.quicksand(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple);

  TextStyle get cardText =>
      GoogleFonts.openSans(fontSize: 17, fontWeight: FontWeight.bold);

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
  TextStyle get quicksandMedium => GoogleFonts.quicksand(
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: Colors.black,
      );

  @override
  TextStyle get quicksandBold => GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black,
      );
}
