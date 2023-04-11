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
  final List<double> _nums = [];
  double? _equalBuffer;
  String _operation = '';
  String _history = '';

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

  void _fillHistory(String val) {
    setState(() {
      if (val == '') {
        _history = '';
      } else {
        _history += '$val ';
      }
    });
  }

  void _insertConsole(String num) {
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

  void _deleteConsole() {
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

  void _cleanConsole(bool historyClean) {
    if (historyClean) {
      setState(() {
        _fillHistory('');
        _operation = '';
        _nums.clear();
      });
    }

    controller.value = const TextEditingValue(
      text: '0',
    );
  }

  void _calculate() {
    double response = 0;

    if (_operation == '/' && _nums[1] == 0) {
      _nums.clear();
      _fillHistory('');
      _fillHistory('ERRO: Não é possível dividir por zero');
      return;
    }

    switch (_operation) {
      case '+':
        response = _nums[0] + _nums[1];
        break;
      case '-':
        response = _nums[0] - _nums[1];
        break;
      case '/':
        response = _nums[0] / _nums[1];
        break;
      case '*':
        response = _nums[0] * _nums[1];
        break;
    }

    _nums.clear();
    _nums.add(response);
    //_operation = '';
    if (!response.toString().contains('.0')) {
      _fillHistory('= $response');
    } else {
      _fillHistory('= ${response.toInt()}');
    }
  }

  void _insertOperation(String op) {
    _equalBuffer = null;
    _fillHistory(controller.text);

    if (_history.contains('=')) {
      _fillHistory('');
      _fillHistory('${_nums[0].toString()} $op');
      //_fillHistory(op);
    } else {
      _nums.add(double.parse(controller.text));
    }

    if (_operation.isEmpty) {
      _fillHistory(op);
    }
    _operation = op;
    _cleanConsole(false);
    if (_nums.length > 1) {
      _calculate();
    }
    //log(_nums.length.toString());
  }

  void _equalClick() {
    if (_history.contains('ERRO')) {
      _fillHistory('');
      return;
    }

    if (_history.contains('=')) {
      return;
      _fillHistory('');
      _fillHistory('${_nums[0].toInt().toString()} $_operation ${_equalBuffer.toString()}');
      //_fillHistory(_operation);
      _equalBuffer ??= double.parse(controller.text);
      //_fillHistory(_equalBuffer.toString());
      _nums.add(_equalBuffer!);
      _cleanConsole(false);
    } else {
      _fillHistory(controller.text);
      _nums.add(double.parse(controller.text));
    }

    _cleanConsole(false);
    _calculate();
    _nums.clear();
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
                        _history,
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
                      onPressed: () => _cleanConsole(true),
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
                      onPressed: () => _deleteConsole(),
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
                      onPressed: () => _insertOperation('/'),
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
                      onPressed: () => _insertOperation('*'),
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
                      onPressed: () => _insertConsole('7'),
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
                      onPressed: () => _insertConsole('8'),
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
                      onPressed: () => _insertConsole('9'),
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
                      onPressed: () => _insertOperation('-'),
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
                      onPressed: () => _insertConsole('4'),
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
                      onPressed: () => _insertConsole('5'),
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
                      onPressed: () => _insertConsole('6'),
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
                      onPressed: () => _insertOperation('+'),
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
                              onPressed: () => _insertConsole('1'),
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
                              onPressed: () => _insertConsole('2'),
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
                              onPressed: () => _insertConsole('3'),
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
                              onPressed: () => _insertConsole('0'),
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
                              onPressed: () => _insertConsole('.'),
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
                      onPressed: () => _equalClick(),
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
