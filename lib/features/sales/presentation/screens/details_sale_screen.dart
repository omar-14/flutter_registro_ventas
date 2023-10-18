import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class DetailsSaleScreen extends ConsumerWidget {
  final String idSale;
  const DetailsSaleScreen({super.key, required this.idSale});

  Future<bool> _mostrarDialogoDeConfirmacion(BuildContext context) async {
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

            final bool isDelete = await _mostrarDialogoDeConfirmacion(context);

            if (!isDelete) return;

            await salesprovider.deleteSale(idSale).then((value) {
              context.pushReplacement("/sales");
            });

            salesprovider.loadNextPage();
          },
          child: const Icon(Icons.arrow_back), // Icono de fecha de regreso
        ),
      ),
      body: _SalesProductsView(idSale: idSale),
    );
  }
}

class _SalesProductsView extends ConsumerStatefulWidget {
  final String idSale;
  const _SalesProductsView({required this.idSale});

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
              ),
              Expanded(
                  child: _ListDetailsSalesView(
                      idSale: widget.idSale,
                      scrollController: scrollController)),
            ],
          )
        : const CustomProgresIndicator();
  }
}

class _ListDetailsSalesView extends ConsumerWidget {
  final ScrollController scrollController;
  final String idSale;

  const _ListDetailsSalesView({
    required this.scrollController,
    required this.idSale,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsSalesState = ref.watch(detailsSalesProvider(idSale));

    print(detailsSalesState.detailsSales.length);

    return Stack(
      children: [
        (detailsSalesState.isLoading)
            ? const CustomProgresIndicator()
            : ListView.builder(
                itemCount: detailsSalesState.detailsSales.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  final detailSale = detailsSalesState.detailsSales[index];

                  return CardItemDetail(
                    detail: detailSale,
                    product: detailSale.product,
                  );
                },
              ),
        CustomButton(
          textButton: 'Finalizar Venta',
          onPressed: () {},
        )
      ],
    );
  }
}
