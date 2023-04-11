import 'package:calculadora_app/styles/button_styles.dart';
import 'package:calculadora_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CalculatorTextButton extends StatelessWidget {
  final String btnText;
  final double btnWidth;
  final double btnHeight;
  final ButtonStyle btnStyle;
  final TextStyle txtStyle;
  final VoidCallback onPressFunc;
  const CalculatorTextButton({
    super.key,
    required this.btnWidth,
    required this.btnHeight,
    required this.onPressFunc,
    required this.btnText,
    required this.btnStyle,
    required this.txtStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnWidth,
      child: ElevatedButton(
        onPressed: () => onPressFunc,
        style: btnStyle,
        child: Text(
          btnText,
          style: txtStyle,
        ),
      ),
    );
  }
}
