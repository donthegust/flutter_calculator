import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get i {
    _instance ??= TextStyles._();
    return _instance!;
  }

  TextStyle get textFuncs => const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 30,
      );

  TextStyle get textNums => const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 24,
        color: Colors.white70,
      );

  TextStyle get textEqual => const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w900,
        fontSize: 30,
      );

  TextStyle get textConsole => const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 28,
      );
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
