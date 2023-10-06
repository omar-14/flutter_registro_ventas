import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/form/product_form_provider.dart';
import 'package:intventory/features/shared/widgets/widgets.dart';

import '../providers/providers.dart';

class ProductScreen extends ConsumerWidget {
  final String idProduct;

  const ProductScreen({super.key, required this.idProduct});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Producto Actualizado")));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(idProduct));

    return Scaffold(
      appBar: AppBar(
        title: Text("Producto: ${productState.product?.nameProduct ?? ""}"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ))
        ],
      ),
      body: productState.isLoading
          ? const FullScreenLoader()
          : _ProductView(product: productState.product!),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
              onPressed: () async {
                String barcodeScanRes;
                try {
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancel', true, ScanMode.QR);
                  print(barcodeScanRes);
                } on PlatformException {
                  barcodeScanRes = 'Failed to get platform version.';
                }
              },
              label: const Text("QR/Barras"),
              icon: const Icon(Icons.qr_code_scanner)),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                ref
                    .read(productFormProvider(productState.product!).notifier)
                    .onFormSubmit()
                    .then((value) {
                  if (!value) return;

                  FocusScope.of(context).unfocus();
                  showSnackbar(context);
                });
              },
              label: const Text("Actualizar"),
              icon: const Icon(Icons.save)),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Generar QR"),
              icon: const Icon(Icons.qr_code_2))
        ],
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final Product product;

  const _ProductView({
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        _ProductFormView(
          product: product,
        )
      ],
    );
  }
}

class _ProductFormView extends ConsumerWidget {
  final Product product;

  const _ProductFormView({
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        // Card(
        //   color: colors.surfaceVariant,
        //   elevation: 2.0,
        //   child: const Padding(
        //     padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
        //     child: Column(children: [
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //       Align(
        //           alignment: Alignment.bottomLeft,
        //           child: Text('test - Filled')),
        //     ]),
        //   ),
        // ),
        const Text('Generales'),
        const SizedBox(height: 15),
        CustomProductField(
          isTopField: true,
          label: 'Nombre',
          initialValue: product.nameProduct,
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onNameProductChanged,
          errorMessage: productForm.nameProduct.errorMessage,
        ),
        CustomProductField(
          // isTopField: true,
          label: 'Marca',
          // keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.brand,
          onChanged:
              ref.read(productFormProvider(product).notifier).onBrandChanged,
          errorMessage: productForm.brand.errorMessage,
        ),
        CustomProductField(
          // isTopField: true,
          label: 'Precio Original',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.originalPrice.toString(),
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onOriginalPriceChanged,
          errorMessage: productForm.originalPrice.errorMessage,
        ),
        CustomProductField(
          // isTopField: true,
          label: 'Precio Publico',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.publicPrice.toString(),
          onChanged:
              ref.read(productFormProvider(product).notifier).onPriceChanged,
          errorMessage: productForm.publicPrice.errorMessage,
        ),
        CustomProductField(
          // isTopField: true,
          label: 'Procentage de ganacia',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.productProfit.toString(),
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onProductProfitChanged,
          errorMessage: productForm.productProfit.errorMessage,
        ),
        CustomProductField(
          // isTopField: true,
          label: 'Tipo de Producto',
          initialValue: product.productType.toString(),
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onProductTypeChanged,
          errorMessage: productForm.productType.errorMessage,
        ),
        CustomProductField(
          isBottomField: true,
          label: 'Stock',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.stock.toString(),
          onChanged: (value) => ref
              .read(productFormProvider(product).notifier)
              .onStockChanged(int.tryParse(value) ?? -1),
          errorMessage: productForm.stock.errorMessage,
        ),
        const SizedBox(height: 100),
      ]),
    );
  }
}
