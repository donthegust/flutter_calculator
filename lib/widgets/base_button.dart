import 'package:calculadora_app/styles/button_styles.dart';
import 'package:calculadora_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CalculatorBaseButton extends StatelessWidget {
  final dynamic btnContent;
  final double? btnFlexWidth;
  final double? btnFlexHeight;
  final VoidCallback onPressFunc;
  final String typeButton;

  const CalculatorBaseButton({
    super.key,
    required this.btnContent,
    this.btnFlexWidth,
    this.btnFlexHeight,
    required this.onPressFunc,
    required this.typeButton,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnStyle = const ButtonStyle();
    TextStyle txtStyle = const TextStyle();

    switch (typeButton.toUpperCase()) {
      case 'EQUAL':
        btnStyle = context.buttonStyles.buttonEqual;
        txtStyle = context.textStyles.textEqual;
        break;
      case 'FUNCS':
        btnStyle = context.buttonStyles.buttonFuncs;
        txtStyle = context.textStyles.textFuncs;
        break;
      case 'NUMS':
        btnStyle = context.buttonStyles.buttonNums;
        txtStyle = context.textStyles.textNums;
        break;
      default:
    }
    return SizedBox(
      width: btnFlexWidth != null
          ? (MediaQuery.of(context).size.width / 4) * btnFlexWidth!
          : (MediaQuery.of(context).size.width / 4),
      height: btnFlexHeight != null
          ? (MediaQuery.of(context).size.width / 4) * btnFlexHeight!
          : (MediaQuery.of(context).size.width / 4),
      child: ElevatedButton(
        onPressed: onPressFunc,
        style: btnStyle,
        child: btnContent.runtimeType == String
            ? Text(
                btnContent,
                style: txtStyle,
              )
            : Icon(
                btnContent,
                color: Colors.black54,
              ),
      ),
    );
  }
}
