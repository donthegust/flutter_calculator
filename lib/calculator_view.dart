import 'dart:developer';

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

  void _insertConsole(String val) {
    var text = controller.text;

    if (text.length > 20) return; //Caso seja inserido valor com mais de 20 digitos
    if (text == '0') {
      //Retira o '0' inicial do console
      text = '';
    }
    if (val != '.') {
      //Verifica se o valor a ser inserido não é um .
      controller.value = TextEditingValue(
        text: text + val,
      );
    } else {
      if (text.isEmpty) {
        //Insere '0' antes do . se for preciso
        controller.value = TextEditingValue(
          text: '0$val',
        );
      } else if (!text.contains('.')) {
        //Insere o ponto no console
        controller.value = TextEditingValue(
          text: text + val,
        );
      }
    }

    //log((double.parse(controller.value.text) + double.parse(controller.value.text)).toString());
  }

  void _deleteConsole() {
    var text = controller.text;
    if (text.length == 1) {
      //Insere um zero caso todos os digitos inseridos tenham sido deletados
      controller.value = const TextEditingValue(
        text: '0',
      );
    } else {
      if (text.isNotEmpty) {
        //Elimina o ultimo digito da String atual do console
        controller.value = TextEditingValue(
          text: text.substring(0, text.length - 1),
        );
      }
    }
  }

  void _cleanConsole(bool historyClean) {
    if (historyClean) {
      //Limpa todo o console caso necessario
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

  bool _floatCheck(String val) {
    return int.parse(val.toString().split('.')[1]) != 0;
  }

  void _calculate() {
    double response = 0;

    if (_operation == '/' && _nums[1] == 0) {
      //Checa se o calculo é uma divisão possivel
      _nums.clear();
      _fillHistory('');
      _fillHistory('ERRO: Não é possível dividir por zero');
      return;
    }

    switch (_operation) {
      //Realiza o calculo
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
    _nums.add(response); //Limpa a lista de numeros e adiciona o resultado do calculo na lista
    if (_floatCheck(response.toString())) {
      _fillHistory('= $response'); //Adiciona o resultado a tela
    } else {
      _fillHistory('= ${response.toInt()}');
    }
  }

  void _insertOperation(String op) {
    if (_history.contains('ERRO')) {
      //Se houver erro no console, limpa ele
      _fillHistory('');
      return;
    }

    _fillHistory(controller.text);

    if (_history.contains('=')) {
      //Reaproveita o resultado anterior e insere um novo operador junto com o valor do console
      _fillHistory('');

      _fillHistory('${_nums[0].toString()} $op');
    } else {
      _nums.add(double.parse(controller.text)); // Adiciona um valor novo valor na Lista
    }

    if (_operation.isEmpty) {
      //Insere a operação na tela
      _operation = op;
      _fillHistory(op);
    } else {
      //Substitui a operação da tela
      _operation = op;
      _fillHistory('');
      if (_floatCheck(_nums[0].toString())) {
        _fillHistory('${_nums[0].toString()} $op'); //Adiciona o resultado a tela
      } else {
        _fillHistory('${_nums[0].toInt().toString()} $op');
      }
      return;
    }

    _cleanConsole(false); //Limpa o console
  }

  void _equalClick() {
    if (_history.contains('ERRO')) {
      //Se houver erro no console, limpa ele
      _fillHistory('');
      return;
    }

    if (_history.contains('=')) {
      //Verifica se o ultimo clique foi no '='
      _fillHistory('');

      _nums.insert(1, double.parse(controller.text));

      if (_floatCheck(_nums[0].toString())) {
        _fillHistory('${_nums[0].toString()} $_operation');
      } else {
        _fillHistory('${_nums[0].toInt().toString()} $_operation');
      }

      if (_floatCheck(_nums[1].toString())) {
        _fillHistory(_nums[1].toString());
      } else {
        _fillHistory(_nums[1].toInt().toString());
      }
    } else {
      if (_operation.isEmpty) {
        //Valida se o calculo é possivel
        return;
      }
      _nums.insert(1, double.parse(controller.text));
      _fillHistory(controller.text);
    }

    _cleanConsole(false);
    _calculate();
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
                      textAlign: TextAlign.right,
                      readOnly: true,
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
