import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'delegates/search_product_delegate.dart';

class SearchAppbar extends ConsumerWidget {
  final String idSale;
  const SearchAppbar({super.key, required this.idSale});

  void showSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // final titleStyle = Theme.of(context).textTheme.titleSmall;
    const titleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

    Future<bool> showConfirmDialog() async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: "Producto no encontrado",
            content:
                "El producto que buscas no fue encontrado, intentalo de nuevo.",
            contentConfirm: "ok",
          );
        },
      );
    }

    void showFormAddProduct(product) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return SingleChildScrollView(
            child: FormAddProduct(
              product: product,
              idSale: idSale,
              onPressed: () async {
                ref
                    .read(detailSaleCreateFormProvider(idSale).notifier)
                    .onFormSubmit(product)
                    .then((value) {
                  Navigator.pop(context);
                  if (!value) {
                    return null;
                  }
                  showSnackbar(
                      context,
                      value
                          ? "Producto Agregado"
                          : "Producto ya en el carrito");
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                  showSnackbar(context, "Error agregando el Producto");
                });
              },
            ),
          );
        },
      );
    }

    return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              ElevatedButton.icon(
                onPressed: () {
                  final saleState = ref.watch(saleProvider(idSale));

                  if (saleState.sale!.isCompleted) {
                    ScaffoldMessenger.of(context).clearSnackBars();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Ya no se puede editar una venta finalizada.'),
                    ));

                    return;
                  }
                  final searchProducts = ref.read(searchProductsProvider);

                  showSearch<Product?>(
                          query: "",
                          context: context,
                          delegate: SearchProductDelegate(
                              searchProducts: ref
                                  .read(searchProductsProvider.notifier)
                                  .searchMoviesByQuery,
                              initialProduct: searchProducts))
                      .then((product) {
                    if (product == null) {
                      return;
                    }
                    showFormAddProduct(product);
                  });
                },
                icon: const Icon(Icons.search),
                label: const Text(
                  'Buscar producto',
                  style: titleStyle,
                ),
              ),
              // const Spacer(),
              IconButton(
                  onPressed: () async {
                    final saleState = ref.watch(saleProvider(idSale));

                    if (saleState.sale!.isCompleted) {
                      ScaffoldMessenger.of(context).clearSnackBars();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Ya no se puede editar una venta finalizada.'),
                      ));

                      return;
                    }

                    String barcodeScanRes = "";
                    try {
                      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                          '#ff6666', 'Cancel', true, ScanMode.QR);

                      if (barcodeScanRes.isNotEmpty && barcodeScanRes != "-1") {
                        Product product = await ref
                            .read(searchProductsProvider.notifier)
                            .searchProductByKey(barcodeScanRes);
                        if (product.id.contains("new")) {
                          showConfirmDialog();
                          return;
                        }

                        showFormAddProduct(product);
                      }
                    } on PlatformException {
                      barcodeScanRes = 'Failed to get platform version.';
                    }
                  },
                  icon:
                      Icon(Icons.qr_code_scanner_sharp, color: colors.primary))
            ]),
          ),
        ));
  }
}
