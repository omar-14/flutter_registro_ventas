import 'package:flutter/material.dart';

class SaleScreen extends StatelessWidget {
  final String idSale;
  const SaleScreen({super.key, required this.idSale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Venta: $idSale",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("Escanear QR"),
            icon: const Icon(Icons.qr_code_scanner),
          )
        ],
      ),
      body: _SalesProductsView(idSale: idSale),
    );
  }
}

class _SalesProductsView extends StatelessWidget {
  const _SalesProductsView({
    // super.key,
    required this.idSale,
  });

  final String idSale;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(idSale));
  }
}
