import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyles? _instance;

  ButtonStyles._();

  static ButtonStyles get i {
    _instance ??= ButtonStyles._();
    return _instance!;
  }

  ButtonStyle get buttonFuncs => const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          //Colors.orange.withAlpha(200),
          Color(0xFFee9b00),
        ),
        overlayColor: MaterialStatePropertyAll(Colors.white38),
        elevation: MaterialStatePropertyAll(3),
      );

  ButtonStyle get buttonNums => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          const Color(0xFFF023047).withOpacity(0.4),
        ),
        overlayColor: const MaterialStatePropertyAll(Colors.white38),
      );

  ButtonStyle get buttonEqual => const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0xFFFB8500),
          //Color(0xFFca6702),
        ),
        overlayColor: MaterialStatePropertyAll(Colors.white38),
      );
}

extension ButtonStylesExtensions on BuildContext {
  ButtonStyles get buttonStyles => ButtonStyles.i;
}
