import 'package:calculadora_app/styles/button_styles.dart';
import 'package:calculadora_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CalculatorIconButton extends StatelessWidget {
  final Icon btnIcon;
  final double btnWidth;
  final double btnHeight;
  final VoidCallback onPressFunc;
  const CalculatorIconButton(
      {super.key, required this.btnWidth, required this.btnHeight, required this.onPressFunc, required this.btnIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnWidth,
      child: ElevatedButton(
        onPressed: () => onPressFunc,
        child: Text(
          'C',
          style: context.textStyles.textFuncs.copyWith(fontSize: 24),
        ),
        style: context.buttonStyles.buttonFuncs,
      ),
    );
  }
}
