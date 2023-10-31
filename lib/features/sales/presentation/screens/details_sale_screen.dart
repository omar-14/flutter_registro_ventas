import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class DetailsSaleScreen extends ConsumerWidget {
  final String idSale;
  const DetailsSaleScreen({super.key, required this.idSale});

  Future<bool> showDialogOfConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          title: "Confirmación de Eliminación",
          content: "¿Estás seguro de que deseas eliminar este Producto?",
          hasCancel: true,
        );
      },
    );
  }

  void showSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesprovider = ref.watch(salesProvider.notifier);
    final detailsSalesState = ref.watch(detailsSalesProvider(idSale));

    return Scaffold(
      appBar: AppBar(
        title: SearchAppbar(idSale: idSale),
        leading: GestureDetector(
          onTap: () async {
            if (detailsSalesState.detailsSales.isNotEmpty) {
              context.pushReplacement("/sales");
              return;
            }

            final bool isDelete = await showDialogOfConfirmation(context);

            if (!isDelete) return;

            await salesprovider.deleteSale(idSale).then((value) {
              context.pushReplacement("/sales");
            });

            salesprovider.loadNextPage();
          },
          child: const Icon(Icons.arrow_back), // Icono de fecha de regreso
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final saleState = ref.watch(saleProvider(idSale));

          if (saleState.sale!.isCompleted) {
            context.go("/sales/$idSale/final");
            return;
          }

          if (detailsSalesState.detailsSales.isEmpty) {
            showSnackbar(context, "Debes agregar productos a la venta.");
            return;
          }

          final likeSale = {"id": idSale, "is_completed": true};

          ref.watch(saleProvider(idSale).notifier).updateSale(likeSale);

          context.go("/sales/$idSale/final");
        },
        label: const Text("Finalizar Venta"),
        icon: const Icon(Icons.shopping_cart_checkout_outlined),
      ),
      body: _SalesProductsView(
          idSale: idSale, showDialogOfConfirmation: showDialogOfConfirmation),
    );
  }
}

class _SalesProductsView extends ConsumerStatefulWidget {
  final String idSale;
  final Future<bool> Function(BuildContext) showDialogOfConfirmation;

  const _SalesProductsView({
    required this.idSale,
    required this.showDialogOfConfirmation,
  });

  @override
  _SalesProductsViewState createState() => _SalesProductsViewState();
}

class _SalesProductsViewState extends ConsumerState<_SalesProductsView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) <=
          scrollController.position.maxScrollExtent) {
        ref
            .read(detailsSalesProvider(widget.idSale).notifier)
            .loadNextPage(widget.idSale);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saleState = ref.watch(saleProvider(widget.idSale));

    return saleState.sale != null
        ? Column(
            children: [
              CardResumeSale(
                totalPrice: saleState.sale?.total.toString() ?? "0",
                totalItems: saleState.sale?.numberOfProducts.toString() ?? "0",
              ),
              Expanded(
                  child: _ListDetailsSalesView(
                      showDialogOfConfirmation: widget.showDialogOfConfirmation,
                      idSale: widget.idSale,
                      scrollController: scrollController)),
            ],
          )
        : const CustomProgresIndicator();
  }
}

class _ListDetailsSalesView extends ConsumerWidget {
  final Future<bool> Function(BuildContext) showDialogOfConfirmation;
  final ScrollController scrollController;
  final String idSale;

  const _ListDetailsSalesView({
    required this.showDialogOfConfirmation,
    required this.scrollController,
    required this.idSale,
  });

  void showSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void showFormUpdateProduct(WidgetRef ref, BuildContext context,
      DetailsSale detail, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return SingleChildScrollView(
          child: FormUpdateProduct(
            product: product,
            detail: detail,
            onPressed: () {
              ref
                  .read(detailSaleUpdateFormProvider(detail).notifier)
                  .onFormSubmit();
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsSalesState = ref.watch(detailsSalesProvider(idSale));
    final saleState = ref.watch(saleProvider(idSale));

    return (detailsSalesState.isLoading)
        ? const CustomProgresIndicator()
        : ListView.builder(
            itemCount: detailsSalesState.detailsSales.length + 1,
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < detailsSalesState.detailsSales.length) {
                final detailSale = detailsSalesState.detailsSales[index];
                final Product? product = detailSale.product;

                return Dismissible(
                  key: Key(detailsSalesState.detailsSales[index].id),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.check, color: Colors.transparent),
                  ),
                  confirmDismiss: (DismissDirection direction) async {
                    if (saleState.sale!.isCompleted) return false;

                    final isDelete = await showDialogOfConfirmation(context);

                    if (!isDelete) {
                      return isDelete;
                    }

                    final isDeleted = await ref
                        .read(detailsSalesProvider(idSale).notifier)
                        .deleteDetailProduct(detailSale.id);

                    return isDeleted;
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Producto eliminado.'),
                      ));
                    }
                  },
                  child: (product != null)
                      ? CardItemDetail(
                          detail: detailSale,
                          product: product,
                          onTap: () {
                            if (saleState.sale!.isCompleted) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Ya no se puede editar una venta finalizada.'),
                              ));

                              return;
                            }

                            showFormUpdateProduct(
                                ref, context, detailSale, product);
                          },
                        )
                      : const CustomProgresIndicator(),
                );
              } else {
                return const SizedBox(height: 80.0);
              }
            },
          );
  }
}
