import 'package:flutter/material.dart';

class CardResumeSale extends StatelessWidget {
  final String totalItems;
  final String totalPrice;

  const CardResumeSale(
      {super.key, this.totalItems = "0", required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    return Card(
      elevation: 5, // Sombra de la Card
      margin: const EdgeInsets.all(16.0), // Margen alrededor de la Card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total: ',
              style: textStyle,
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              totalPrice,
              style: textStyle,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Total de items: ',
              style: textStyle,
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              totalItems,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
