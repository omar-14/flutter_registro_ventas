import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intventory/features/inventory/presentation/providers/providers.dart';
// import 'package:intventory/features/inventory/presentation/widgets/widgets.dart';
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

    // scrollController.addListener(() {
    //   if ((scrollController.position.pixels + 40) <=
    //       scrollController.position.maxScrollExtent) {
    //     ref.read(productsProvider.notifier).loadNextPage();
    //   }
    // });
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

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            title: Text("Producto: ${product.nameProduct}"),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marca: ${product.brand}"),
                      // Text("Precio: ${product.publicUnitPrice}"),
                      // Text("Unidades: ${product.stock}"),
                      // Text("Tipo: ${product.productType}"),
                    ])),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined),
            onTap: () => context.push("/product/${product.id}"),
          ),
        );
      },
    );
  }
}
