import 'package:calculadora_app/controller/console_controller.dart';
import 'package:calculadora_app/styles/text_styles.dart';
import 'package:calculadora_app/widgets/base_button.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  @override
  void initState() {
    ConsoleController.i.controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    ConsoleController.i.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        ConsoleController.i.getHistory,
                        style: context.textStyles.textConsole.copyWith(color: Colors.white54),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: ConsoleController.i.controller,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        style: context.textStyles.textConsole,
                        decoration: null,
                      ),
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
                  CalculatorBaseButton(
                    btnContent: 'C',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.cleanConsole(true);
                    }),
                    typeButton: 'FUNCS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '%',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.percentValue();
                    }),
                    typeButton: 'FUNCS',
                  ),
                  CalculatorBaseButton(
                    btnContent: Icons.backspace_outlined,
                    onPressFunc: () => setState(() {
                      ConsoleController.i.deleteConsole();
                    }),
                    typeButton: 'FUNCS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '/',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.insertOperation('/');
                    }),
                    typeButton: 'FUNCS',
                  ),
                ],
              ),
              Row(
                children: [
                  CalculatorBaseButton(
                    btnContent: '7',
                    onPressFunc: () => ConsoleController.i.insertConsole('7'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '8',
                    onPressFunc: () => ConsoleController.i.insertConsole('8'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '9',
                    onPressFunc: () => ConsoleController.i.insertConsole('9'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '*',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.insertOperation('*');
                    }),
                    typeButton: 'FUNCS',
                  ),
                ],
              ),
              Row(
                children: [
                  CalculatorBaseButton(
                    btnContent: '4',
                    onPressFunc: () => ConsoleController.i.insertConsole('4'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '5',
                    onPressFunc: () => ConsoleController.i.insertConsole('5'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '6',
                    onPressFunc: () => ConsoleController.i.insertConsole('6'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '-',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.insertOperation('-');
                    }),
                    typeButton: 'FUNCS',
                  ),
                ],
              ),
              Row(
                children: [
                  CalculatorBaseButton(
                    btnContent: '1',
                    onPressFunc: () => ConsoleController.i.insertConsole('1'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '2',
                    onPressFunc: () => ConsoleController.i.insertConsole('2'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '3',
                    onPressFunc: () => ConsoleController.i.insertConsole('3'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '+',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.insertOperation('+');
                    }),
                    typeButton: 'FUNCS',
                  ),
                ],
              ),
              Row(
                children: [
                  CalculatorBaseButton(
                    btnContent: '0',
                    onPressFunc: () => ConsoleController.i.insertConsole('0'),
                    typeButton: 'NUMS',
                    btnFlexWidth: 2,
                  ),
                  CalculatorBaseButton(
                    btnContent: '.',
                    onPressFunc: () => ConsoleController.i.insertConsole('.'),
                    typeButton: 'NUMS',
                  ),
                  CalculatorBaseButton(
                    btnContent: '=',
                    onPressFunc: () => setState(() {
                      ConsoleController.i.equalClick();
                    }),
                    typeButton: 'EQUAL',
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
