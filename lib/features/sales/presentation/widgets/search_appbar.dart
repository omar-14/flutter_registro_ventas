import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

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
    final titleStyle = Theme.of(context).textTheme.titleSmall;

    final detailProvider = ref.read(detailsSalesProvider(idSale).notifier);

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
        builder: (builder) {
          return FormAddProduct(
            product: product,
            onPressed: () async {
              final newDetail = {
                "id_product": product.id,
                "id_sale": idSale,
                "sub_total": 31,
                "product_quantity": 3
              };

              await detailProvider.createDetailSale(newDetail).then((value) {
                Navigator.pop(context);
                print(value);
                if (value == null) return;

                showSnackbar(context,
                    value ? "Producto Agregado" : "Producto ya en el carrito");
              });
            },
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
                  final searchMovies = ref.read(searchProductsProvider);

                  showSearch<Product?>(
                          query: "",
                          context: context,
                          delegate: SearchProductDelegate(
                              searchProducts: ref
                                  .read(searchProductsProvider.notifier)
                                  .searchMoviesByQuery,
                              initialProduct: searchMovies))
                      .then((product) {
                    if (product == null) {
                      showConfirmDialog();
                      return;
                    }
                    showFormAddProduct(product);
                  });
                },
                icon: const Icon(Icons.search),
                label: Text(
                  'Buscar producto',
                  style: titleStyle,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () async {
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
