import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/shared/widgets/widgets.dart';

class FormAddProduct extends ConsumerWidget {
  final Product? product;
  final DetailsSale? detail;
  final void Function()? onPressed;

  const FormAddProduct({super.key, this.product, this.onPressed, this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textStyleLabel = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
    const textStyleContain = TextStyle(fontSize: 25);

    return SizedBox(
      height: 300, // Altura del BottomSheet
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          color: Colors.blueGrey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(children: [
                  const Text(
                    "Producto: ",
                    style: textStyleLabel,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product?.nameProduct ?? "",
                    style: textStyleContain,
                  ),
                ]),
                Row(
                  children: [
                    const Text(
                      "Marca: ",
                      style: textStyleLabel,
                    ),
                    const SizedBox(width: 8),
                    Text(product?.nameProduct ?? "", style: textStyleContain),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Tipo: ",
                      style: textStyleLabel,
                    ),
                    const SizedBox(width: 8),
                    Text(product?.nameProduct ?? "", style: textStyleContain)
                  ],
                ),
                const SizedBox(height: 10),
                CustomProductField(
                  isTopField: true,
                  isBottomField: true,
                  label: 'Cantidad',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: detail?.productQuantity.toString() ?? "0",
                  onChanged: (value) {},
                  // errorMessage:
                  // productForm.stock.errorMessage,
                ),
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: onPressed,
                            child: const Text(
                              'Guardar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
