import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/shared/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class DetailsSaleScreen extends ConsumerWidget {
  final String idSale;
  const DetailsSaleScreen({super.key, required this.idSale});

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
    final saleState = ref.watch(saleProvider(idSale));
    final salesState = ref.watch(salesProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppbar(),
        leading: GestureDetector(
          onTap: () async {
            if (saleState.sale!.isCompleted) {
              context.pushReplacement("/sales");
              return;
            }

            final bool isDelete = await _mostrarDialogoDeConfirmacion(context);

            if (!isDelete) return;

            await salesState.deleteSale(idSale).then((value) {
              context.pushReplacement("/sales");
            });

            salesState.loadNextPage();
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
    // scrollController.addListener(() {
    //   if ((scrollController.position.pixels + 100) <=
    //       scrollController.position.maxScrollExtent) {
    //     ref.read(detailsSalesProvider(widget.idSale)).loadNextPage(widget.idSale);
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    final saleState = ref.watch(saleProvider(widget.idSale));

    return saleState.sale != null
        ? Column(
            children: [
              Card(
                elevation: 5, // Sombra de la Card
                margin:
                    const EdgeInsets.all(16.0), // Margen alrededor de la Card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total: ',
                        style: textStyle,
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Text(
                        (saleState.sale == null)
                            ? ""
                            : saleState.sale!.total.toString(),
                        style: textStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Total de items: ',
                        style: textStyle,
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      const Text(
                        '20',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: _ListDetailsSalesView(
                      idSale: widget.idSale,
                      scrollController: scrollController)),
            ],
          )
        : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                Text("Cargando....")
              ],
            ),
          );
  }
}

class _ListDetailsSalesView extends ConsumerWidget {
  final String idSale;
  const _ListDetailsSalesView({
    // super.key,
    required this.scrollController,
    required this.idSale,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsSalesState = ref.watch(detailsSalesProvider(idSale));

    return Stack(
      children: [
        ListView.builder(
          itemCount: detailsSalesState.detailsSales.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            final detailSale = detailsSalesState.detailsSales[index];
            const textStyle =
                TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
            // final colors = Theme.of(context).colorScheme;
            // const radius = Radius.circular(15);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Card(
                color: Colors.indigo[300],
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return SizedBox(
                          height: 500, // Altura del BottomSheet
                          child: Center(
                            child: Text(
                                'Contenido del BottomSheet para ${detailSale.product!.nameProduct}'),
                          ),
                        );
                      },
                    );
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                  ),
                  title: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${detailSale.product!.nameProduct} - ${detailSale.product!.brand}",
                          style: textStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Subtotal: ",
                            style: textStyle,
                          ),
                          Text(detailSale.subTotal),
                          const SizedBox(width: 10),
                          const Text(
                            "Cantidad: ",
                            style: textStyle,
                          ),
                          Text(detailSale.productQuantity.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Text(
                'Finalizar Venta',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}
