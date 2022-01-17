import 'package:amplify_cognito_flutter/color/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget whiteColorInButtonText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color:  Colors.white,)),
  );
}

Widget titleText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
  );
}

Widget deviceNameText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
  );
}

Widget settingNameText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
  );
}

Widget settingDescriptionText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff787878))),
  );
}

Widget workingTimeText(String content) {
  return Text(
    content,
    style: GoogleFonts.notoSans(
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, decoration: TextDecoration.underline , color: mainPurpleColor)),
  );
}