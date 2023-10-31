import 'package:flutter/material.dart';

class CalculatorForm extends StatefulWidget {
  final double total;
  const CalculatorForm({super.key, required this.total});

  @override
  CalculatorFormState createState() => CalculatorFormState();
}

class CalculatorFormState extends State<CalculatorForm> {
  final TextEditingController number1Controller = TextEditingController();
  String result = '';

  void calculateResult() {
    double num1 = double.tryParse(number1Controller.text) ?? 0;
    double subtractionResult = num1 - widget.total;
    setState(() {
      result = 'Cambio : \$$subtractionResult pesos';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: number1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Se paga con'),
          ),
          ElevatedButton(
            onPressed: calculateResult,
            child: const Text('Calcular'),
          ),
          Text(
            result,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
