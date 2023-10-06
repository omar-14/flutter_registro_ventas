import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/form/product_form_provider.dart';
import 'package:intventory/features/inventory/presentation/widgets/widgets.dart';
import 'package:intventory/features/shared/widgets/widgets.dart';

import '../providers/providers.dart';

class ProductScreen extends ConsumerWidget {
  final String idProduct;

  const ProductScreen({super.key, required this.idProduct});

  void showSnackbar(BuildContext context, {bool isDelete = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: !isDelete
            ? Text(
                "Producto ${idProduct.contains("new") ? "Creado" : "Actualizado"}")
            : const Text("Producto Eliminado")));
  }

  Future<bool> _mostrarDialogoDeConfirmacion(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de Eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar este Producto?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(idProduct));

    return Scaffold(
      appBar: AppBar(
        title: Text((productState.product?.nameProduct == "")
            ? "Nuevo Producto"
            : "Modifica producto"),
        actions: productState.product?.nameProduct != ""
            ? [
                IconButton(
                    onPressed: () async {
                      final bool isDelete =
                          await _mostrarDialogoDeConfirmacion(context);

                      if (!isDelete) return;

                      ref
                          .read(deleteProductsProvider.notifier)
                          .deleteProductById(productState.product!.id)
                          .then((value) {
                        if (!value) return;

                        FocusScope.of(context).unfocus();
                        showSnackbar(context, isDelete: value);
                        context.pop();
                      });
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ))
              ]
            : [],
      ),
      body: productState.isLoading
          ? const FullScreenLoader()
          : _ProductView(product: productState.product!),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
              onPressed: () {
                ref
                    .read(productFormProvider(productState.product!).notifier)
                    .onFormSubmit()
                    .then((value) {
                  if (!value) return;

                  FocusScope.of(context).unfocus();
                  showSnackbar(context);
                  context.pop();
                });
              },
              label: const Text("Actualizar"),
              icon: const Icon(Icons.save)),
          const SizedBox(
            height: 20,
          ),
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
    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        ProductCard(product: product),
        const SizedBox(height: 15),
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
          label: 'Marca',
          initialValue: product.brand,
          onChanged:
              ref.read(productFormProvider(product).notifier).onBrandChanged,
          errorMessage: productForm.brand.errorMessage,
        ),
        CustomProductField(
          label: 'Precio Original',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.originalPrice.toString(),
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onOriginalPriceChanged,
          errorMessage: productForm.originalPrice.errorMessage,
        ),
        CustomProductField(
          label: 'Precio Publico',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.publicPrice.toString(),
          onChanged:
              ref.read(productFormProvider(product).notifier).onPriceChanged,
          errorMessage: productForm.publicPrice.errorMessage,
        ),
        CustomProductField(
          label: 'Procentage de ganacia',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          initialValue: product.productProfit.toString(),
          onChanged: ref
              .read(productFormProvider(product).notifier)
              .onProductProfitChanged,
          errorMessage: productForm.productProfit.errorMessage,
        ),
        CustomProductField(
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
