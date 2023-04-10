import 'dart:developer';
import 'dart:ffi';

import 'package:calculadora_app/styles/button_styles.dart';
import 'package:calculadora_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  late final TextEditingController controller;
  String operation = '';
  List<double> nums = [];
  String history = '';

  @override
  void initState() {
    controller = TextEditingController();
    controller.value = const TextEditingValue(
      text: '0',
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fillHistory(String val) {
    setState(() {
      if (val == '') {
        history = '';
      } else {
        history += '$val ';
      }
    });
  }

  void insertConsole(String num) {
    var text = controller.text;

    if (text.length > 20) return;
    if (text == '0') {
      text = '';
    }
    if (num != '.') {
      controller.value = TextEditingValue(
        text: text + num,
      );
    } else {
      if (text.isEmpty) {
        controller.value = TextEditingValue(
          text: '0$num',
        );
      } else if (!text.contains('.')) {
        controller.value = TextEditingValue(
          text: text + num,
        );
      }
    }

    //log((double.parse(controller.value.text) + double.parse(controller.value.text)).toString());
  }

  void deleteConsole() {
    var text = controller.text;
    if (text.length == 1) {
      controller.value = const TextEditingValue(
        text: '0',
      );
    } else {
      if (text.isNotEmpty) {
        controller.value = TextEditingValue(
          text: text.substring(0, text.length - 1),
        );
      }
    }
  }

  void cleanConsole() {
    controller.value = const TextEditingValue(
      text: '0',
    );
  }

  void calculate() {
    double response = 0;

    if (operation == '/' && nums[1] == 0) {
      history = 'ERRO: Não é possível dividir por zero';
      return;
    }

    switch (operation) {
      case '+':
        response = nums[0] + nums[1];
        break;
      case '-':
        response = nums[0] - nums[1];
        break;
      case '/':
        response = nums[0] / nums[1];
        break;
      case '*':
        response = nums[0] * nums[1];
        break;
    }

    nums.clear();
    nums.add(response);
    fillHistory('= $response');
  }

  void insertOperation(String op) {
    fillHistory(controller.text);
    nums.add(double.parse(controller.text));
    fillHistory(op);
    operation = op;
    cleanConsole();
    if (nums.length > 1) {
      calculate();
    }
    log(nums.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    final double btnWidth = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.black87,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        history,
                        style: context.textStyles.textConsole.copyWith(color: Colors.white54),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller,
                      //obscureText: true,
                      //maxLength: 30,
                      textAlign: TextAlign.right,
                      readOnly: true,
                      //decoration: InputDecoration(focusColor: null),
                      style: context.textStyles.textConsole,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => cleanConsole(),
                      child: Text(
                        'C',
                        style: context.textStyles.textFuncs.copyWith(fontSize: 24),
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => deleteConsole(),
                      child: const Icon(
                        Icons.backspace_outlined,
                        color: Colors.black54,
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertOperation('/'),
                      child: Text(
                        '/',
                        style: context.textStyles.textFuncs,
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertOperation('*'),
                      child: Text(
                        '*',
                        style: context.textStyles.textFuncs,
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('7'),
                      child: Text(
                        '7',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('8'),
                      child: Text(
                        '8',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('9'),
                      child: Text(
                        '9',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertOperation('-'),
                      child: Text(
                        '-',
                        style: context.textStyles.textFuncs,
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('4'),
                      child: Text(
                        '4',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('5'),
                      child: Text(
                        '5',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertConsole('6'),
                      child: Text(
                        '6',
                        style: context.textStyles.textNums,
                      ),
                      style: context.buttonStyles.buttonNums,
                    ),
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: btnWidth,
                    child: ElevatedButton(
                      onPressed: () => insertOperation('+'),
                      child: Text(
                        '+',
                        style: context.textStyles.textFuncs,
                      ),
                      style: context.buttonStyles.buttonFuncs,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: btnWidth,
                            height: btnWidth,
                            child: ElevatedButton(
                              onPressed: () => insertConsole('1'),
                              child: Text(
                                '1',
                                style: context.textStyles.textNums,
                              ),
                              style: context.buttonStyles.buttonNums,
                            ),
                          ),
                          SizedBox(
                            width: btnWidth,
                            height: btnWidth,
                            child: ElevatedButton(
                              onPressed: () => insertConsole('2'),
                              child: Text(
                                '2',
                                style: context.textStyles.textNums,
                              ),
                              style: context.buttonStyles.buttonNums,
                            ),
                          ),
                          SizedBox(
                            width: btnWidth,
                            height: btnWidth,
                            child: ElevatedButton(
                              onPressed: () => insertConsole('3'),
                              child: Text(
                                '3',
                                style: context.textStyles.textNums,
                              ),
                              style: context.buttonStyles.buttonNums,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: (btnWidth) * 2,
                            height: btnWidth,
                            child: ElevatedButton(
                              onPressed: () => insertConsole('0'),
                              child: Text(
                                '0',
                                style: context.textStyles.textNums,
                              ),
                              style: context.buttonStyles.buttonNums,
                            ),
                          ),
                          SizedBox(
                            width: btnWidth,
                            height: btnWidth,
                            child: ElevatedButton(
                              onPressed: () => insertConsole('.'),
                              child: Text(
                                ',',
                                style: context.textStyles.textNums,
                              ),
                              style: context.buttonStyles.buttonNums,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: btnWidth,
                    height: (btnWidth) * 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        '=',
                        style: context.textStyles.textEqual,
                      ),
                      style: context.buttonStyles.buttonEqual,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
