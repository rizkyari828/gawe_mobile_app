import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF004d98);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);
Color birumuda = Color(0xFF039ec7);
Color tombollamar = Color(0xFF4cb050);
Color backgroundColor = Color(0xFFF2F2F2);
// Color backgroundColor = Color.fromRGBO(247,248,253, 0.0);
Color borderColor = Color(0xFFf2f2f2);




TextStyle blackTextfont = GoogleFonts.lato()
    .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
TextStyle whiteTextfont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextfont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextfont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);
