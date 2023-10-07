import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/config/config.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

class SaleScreen extends StatelessWidget {
  final String idSale;
  const SaleScreen({super.key, required this.idSale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Venta: $idSale",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("Escanear QR"),
            icon: const Icon(Icons.qr_code_scanner),
          )
        ],
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
    final detailsSalesState = ref.watch(detailsSalesProvider(widget.idSale));
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    return Column(
      children: [
        const Card(
          elevation: 5, // Sombra de la Card
          margin: EdgeInsets.all(16.0), // Margen alrededor de la Card
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total: ',
                  style: textStyle,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  '1000',
                  style: textStyle,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Total de items: ',
                  style: textStyle,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  '20',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: _ListDetailsSalesView(
                detailsSalesState: detailsSalesState,
                scrollController: scrollController)),
      ],
    );
  }
}

class _ListDetailsSalesView extends StatelessWidget {
  const _ListDetailsSalesView({
    // super.key,
    required this.detailsSalesState,
    required this.scrollController,
  });

  final DetailsSalesState detailsSalesState;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: detailsSalesState.detailsSales.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        final detailSale = detailsSalesState.detailsSales[index];
        const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
        final colors = Theme.of(context).colorScheme;
        const radius = Radius.circular(15);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Container(
            // padding: const EdgeInsets.only(bottom: 0, top: 15),
            decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                    bottomLeft: radius,
                    bottomRight: radius),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ]),
            child: ListTile(
                title: Row(
                  children: [
                    const Text(
                      "Producto: ",
                      style: textStyle,
                    ),
                    Text(detailSale.idProduct.substring(1, 5)),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Marca: ",
                      style: textStyle,
                    ),
                    Text(detailSale.idProduct.substring(1, 5)),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Tipo: ",
                      style: textStyle,
                    ),
                    Text(detailSale.idProduct.substring(1, 5)),
                  ],
                ),
                subtitle: Row(
                  children: [
                    const Text(
                      "Subtotal: ",
                      style: textStyle,
                    ),
                    Text(detailSale.subTotal),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Cantidad: ",
                      style: textStyle,
                    ),
                    Text(detailSale.productQuantity.toString()),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
