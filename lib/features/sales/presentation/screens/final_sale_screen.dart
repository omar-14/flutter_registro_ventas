import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';

class FinalSaleScreen extends ConsumerWidget {
  final String idSale;
  const FinalSaleScreen({super.key, required this.idSale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleState = ref.watch(saleProvider(idSale));

    final saleDate = saleState.sale!.createdAt.toString().split(" ")[0];
    final saleHour =
        saleState.sale!.createdAt.toString().split(" ")[1].split(".")[0];

    const titileStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Venta"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go("/sales");
        },
        label: const Text("Salir"),
        icon: const Icon(Icons.output),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "Destalles de la venta",
                          style: titileStyle,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Text(
                              "Fecha: ",
                              style: titileStyle,
                            ),
                            Text(saleDate, style: textStyle),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Hora: ",
                              style: titileStyle,
                            ),
                            Text(saleHour, style: textStyle),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Total de items de la compra: ",
                              style: titileStyle,
                            ),
                            Text(saleState.sale!.numberOfProducts
                                .toString()
                                .split(".")[0]),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Total: ",
                              style: titileStyle,
                            ),
                            Text(saleState.sale!.total.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CalculatorForm(
                  total: saleState.sale!.total,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
