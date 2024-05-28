import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppColor {
  static MaterialColor colorScheme = const MaterialColor(
    0xFFEB5D2D,
    <int, Color>{
      50: Color(0xFFEB5D2D),
      100: Color(0xFFEB5D2D),
      200: Color(0xFFEB5D2D),
      300: Color(0xFFEB5D2D),
      400: Color(0xFFEB5D2D),
      500: Color(0xFFEB5D2D),
      600: Color(0xFFEB5D2D),
      700: Color(0xFFEB5D2D),
      800: Color(0xFFEB5D2D),
      900: Color(0xFFEB5D2D),
    },
  );

  // // ignore: constant_identifier_names
  // static const Color dark = Color(0xFF222048);
  // static const Color accentDark = Color.fromARGB(255, 39, 39, 39);
  // static const Color dark = Color.fromARGB(255, 21, 0, 46);
  
  static const Color dark = Color(0xFF211D49);
  static const Color accentDark =  Color(0xFF22224F);
  static const Color hintText = Color.fromARGB(255, 188, 188, 188);
  static const Color accentLight = Color(0xFFF5F5F5);
  static const Color orange = Color(0xFFEB5D2D);
  static const Color cyan = Color(0xFFEB5D2D);
  static const Color red = Color(0xFFEB5D2D);
  static const Color error = red;
  static const Color valid = Color(0xFFEB5D2D);
  static const Color white = Color(0xFFFFFFFF);
}
Color getColor(String category) {
  switch (category) {
    case kVisaRequired:
      return kVisaRequiredColor;
    case kVisaOnArrival:
      return kVisaOnArrivalColor;
    case kVisaFree:
      return kVisaFreeColor;
    case kCovidBan:
      return kCovidBanColor;
    case kNoAdmission:
      return kNoAdmissionColor;
    default:
      return kNoAdmissionColor;
  }
}
