import 'package:flutter/material.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/form/product_form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final productForm = ref.watch(productFormProvider(product));

    return Column(
      children: [
        Card(
          color: colors.surfaceVariant,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Column(children: [
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Toca para Editar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                            onPressed: () async {
                              String barcodeScanRes;
                              try {
                                barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                        '#ff6666', 'Cancel', true, ScanMode.QR);

                                if (barcodeScanRes.isNotEmpty &&
                                    barcodeScanRes != "-1") {
                                  ref
                                      .read(
                                          productFormProvider(product).notifier)
                                      .onKeyChanged(barcodeScanRes);
                                  product.key = barcodeScanRes;
                                }
                                // print(barcodeScanRes);
                              } on PlatformException {
                                barcodeScanRes =
                                    'Failed to get platform version.';
                              }
                            },
                            icon: const Icon(
                              Icons.qr_code,
                              size: 40,
                            ),
                            label: Text('Codigo: ${product.key}',
                                overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  )),
              (productForm.key.errorMessage != null)
                  ? SizedBox(
                      height: 25,
                      child: TextFormField(
                          onChanged: ref
                              .read(productFormProvider(product).notifier)
                              .onKeyChanged,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black54),
                          initialValue: product.key,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              isDense: true,
                              errorText: productForm.key.errorMessage,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40)),
                              errorBorder: const OutlineInputBorder().copyWith(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)))),
                    )
                  : const SizedBox()
            ]),
          ),
        )
      ],
    );
  }
}
