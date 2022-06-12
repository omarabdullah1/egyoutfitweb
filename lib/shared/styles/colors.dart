import 'package:flutter/material.dart';

const Color defaultColor = MaterialColor(
  0xFF0B1423,
  <int, Color>{
    50: Color(0xFFe6e7e9),
    100: Color(0xFFced0d3),
    200: Color(0xFFb5b8bd),
    300: Color(0xFF9DA1A7),
    400: Color(0xFF858991),
    500: Color(0xFF6C727B),
    600: Color(0xFF545A65),
    700: Color(0xFF3B424E),
    800: Color(0xFF232B38),
    900: Color(0xFF0B1423),
  },
);

const defaultColor2 = Color(0xFFEC981A);

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
} // you can d
