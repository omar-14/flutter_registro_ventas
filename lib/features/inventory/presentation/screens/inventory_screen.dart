import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/presentation/providers/providers.dart';
import 'package:intventory/features/shared/shared.dart';
import 'package:go_router/go_router.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(title: const CustomAppbar()),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push("/product/new"),
          label: const Text("Agregar Producto"),
          icon: const Icon(Icons.add)),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) <=
          scrollController.position.maxScrollExtent) {
        ref.read(productsProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return ListView.builder(
      itemCount: productsState.products.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        final product = productsState.products[index];
        const titileStyle =
            TextStyle(fontWeight: FontWeight.bold, fontSize: 19);
        const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Card(
            child: ListTile(
              title: Text(
                "Producto: ${product.nameProduct}",
                style: titileStyle,
              ),
              subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Marca: ",
                              style: textStyle,
                            ),
                            Text(product.brand),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Precio: ",
                              style: textStyle,
                            ),
                            Text(product.publicPrice),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Text(
                              "Tipo: ",
                              style: textStyle,
                            ),
                            Text(
                              product.productType,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Existencias: ",
                              style: textStyle,
                            ),
                            Text(product.stock.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: product.stock > 0
                                        ? const Color.fromARGB(
                                            255, 35, 177, 108)
                                        : Colors.redAccent)),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ])),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () => context.push("/product/${product.id}"),
            ),
          ),
        );
      },
    );
  }
}
