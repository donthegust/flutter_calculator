import 'package:flutter/material.dart';

class ConsoleController {
  late final TextEditingController controller;
  final List<double> _nums = [];
  String _operation = '';
  String _history = '';

  String get getHistory => _history;

  static ConsoleController i = ConsoleController();

  void fillHistory(String val) {
    if (val == '') {
      //Limpa o histórico do console
      _history = '';
    } else {
      //Insere valores no histórico
      _history += '$val ';
    }
  }

  void insertConsole(String val) {
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

  void deleteConsole() {
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

  void cleanConsole(bool historyClean) {
    if (historyClean) {
      //Reinicia todo o console e variaveis caso necessario
      fillHistory('');
      _operation = '';
      _nums.clear();
    }

    //Limpa o console
    controller.value = const TextEditingValue(
      text: '0',
    );
  }

  bool floatCheck(String val) {
    //Verifica de o valor é um float ou int
    return int.parse(val.toString().split('.')[1]) != 0;
  }

  void percentValue() {
    var text = controller.text;
    if (_nums.isEmpty) {
      //Trasforma o valor do console em porcentagem
      text = (double.parse(text) / 100).toString();
      controller.value = TextEditingValue(
        text: text,
      );
    } else {
      //Insere a porcetagem solicitada do valor um no console
      double response = (_nums[0] / 100) * double.parse(text);
      controller.value = TextEditingValue(
        text: response.toString(),
      );
    }
  }

  void calculate() {
    double response = 0;

    if (_operation == '/' && _nums[1] == 0) {
      //Checa se o calculo é uma divisão possivel
      _nums.clear();
      fillHistory('');
      fillHistory('ERRO: Não é possível dividir por zero');
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
    if (floatCheck(response.toString())) {
      //Adiciona o resultado a tela
      fillHistory('= $response');
    } else {
      fillHistory('= ${response.toInt()}');
    }
  }

  void insertOperation(String op) {
    if (_history.contains('ERRO')) {
      //Se houver erro no console, limpa ele
      fillHistory('');
      return;
    }

    fillHistory(controller.text);

    if (_history.contains('=')) {
      //Reaproveita o resultado anterior e insere um novo operador junto com o valor do console
      fillHistory('');
      fillHistory('${_nums[0].toString()} $op');
    } else {
      // Adiciona um valor novo valor na Lista
      _nums.add(double.parse(controller.text));
    }

    if (_operation.isEmpty) {
      //Insere a operação na tela
      _operation = op;
      fillHistory(op);
    } else {
      //Substitui a operação da tela
      _operation = op;
      fillHistory('');
      if (floatCheck(_nums[0].toString())) {
        //Adiciona o resultado a tela
        fillHistory('${_nums[0].toString()} $op');
      } else {
        fillHistory('${_nums[0].toInt().toString()} $op');
      }
      cleanConsole(false);
      return;
    }

    cleanConsole(false); //Limpa o console
  }

  void equalClick() {
    if (_history.contains('ERRO')) {
      //Se houver erro no console, limpa ele
      fillHistory('');
      return;
    }

    if (_history.contains('=')) {
      //Verifica se o ultimo clique foi no '='
      fillHistory('');

      _nums.insert(1, double.parse(controller.text));

      if (floatCheck(_nums[0].toString())) {
        fillHistory('${_nums[0].toString()} $_operation');
      } else {
        fillHistory('${_nums[0].toInt().toString()} $_operation');
      }

      if (floatCheck(_nums[1].toString())) {
        fillHistory(_nums[1].toString());
      } else {
        fillHistory(_nums[1].toInt().toString());
      }
    } else {
      if (_operation.isEmpty) {
        //Valida se o calculo é possivel
        return;
      }
      _nums.insert(1, double.parse(controller.text));
      fillHistory(controller.text);
    }

    cleanConsole(false);
    calculate();
  }
}
