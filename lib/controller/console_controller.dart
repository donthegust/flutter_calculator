import 'package:flutter/material.dart';

class ConsoleController extends ChangeNotifier {
  late final TextEditingController controller;
  final List<double> _nums = [];
  String _operation = '';
  String _history = '';

  static ConsoleController i = ConsoleController();

  //notifyChange();
}
