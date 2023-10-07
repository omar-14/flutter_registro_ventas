import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:intventory/features/inventory/domain/domain.dart';
import 'delegates/search_product_delegate.dart';

import '../../inventory/presentation/providers/search/search_products_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleSmall;

    void pushToScreen(String path) {
      context.push(path);
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
                    if (product == null) return;
                    pushToScreen('/product/${product.id}');
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
                          product.id = "${product.id}-$barcodeScanRes";
                        }

                        pushToScreen('/product/${product.id}');
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
